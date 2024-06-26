#!/bin/sh
#
# Copy the MkDocs site/* contents to the CO DNR GCP website:
# - replace all the files on the web with local files

# Supporting functions, alphabetized.

buildMkDocsSite() {
  # First build the site so that the "site" folder contains current content:
  # - "mkdocs serve" does not do this
  cd ${mkdocsProjectFolder}
  if [ "${operatingSystem}" = "mingw" ]; then
    # Use the Windows Python with Git Bash.
    py -m mkdocs build --clean
  else
    # General case.
    mkdocs build --clean
  fi
}

# Make sure the MkDocs version is consistent with the documentation content:
# - require that at least version 1.0 is used because of use_directory_urls = True default
# - must use "file.md" in internal links whereas previously "file" would work
# - it is not totally clear whether version 1 is needed but try this out to see if it helps avoid broken links
checkMkdocsVersion() {
  # Required MkDocs version is at least 1.
  requiredMajorVersion="1"
  if [ ${operatingSystem} = "mingw" ]; then
    # Git bash mkdocs --version gives: __main__.py, version 1.0.4 from C:\Users\sam\AppData\Local\Programs\Python\Python37\lib\site-packages\mkdocs (Python 3.7)
    # Use the Windows Python with Git Bash.
    mkdocsVersionFull=$(py -m mkdocs --version)
  else
    # General case.
    # On Cygwin, mkdocs --version gives:  mkdocs, version 1.0.4 from /usr/lib/python3.6/site-packages/mkdocs (Python 3.6)
    # On Debian Linux, similar to Cygwin:  mkdocs, version 0.17.3
    mkdocsVersionFull=$(mkdocs --version)
  fi
  echo "MkDocs --version:  ${mkdocsVersionFull}"
  mkdocsVersion=$(echo ${mkdocsVersionFull} | cut -d ' ' -f 3)
  echo "MkDocs full version number:  ${mkdocsVersion}"
  mkdocsMajorVersion=$(echo ${mkdocsVersion} | cut -d '.' -f 1)
  echo "MkDocs major version number:  ${mkdocsMajorVersion}"
  if [ "${mkdocsMajorVersion}" -lt "${requiredMajorVersion}" ]; then
    echo ""
    echo "MkDocs version for this documentation must be version ${requiredMajorVersion} or later."
    echo "MkDocs mersion that is found is ${mkdocsMajorVersion}, from full version ${mkdocsVersion}."
    exit 1
  else
    echo ""
    echo "MkDocs major version (${mkdocsMajorVersion}) is OK for this documentation."
  fi
}

# Determine the operating system that is running the script:
# - mainly care whether Cygwin
checkOperatingSystem()
{
  if [ ! -z "${operatingSystem}" ]; then
    # Have already checked operating system so return.
    return
  fi
  operatingSystem="unknown"
  os=$(uname | tr [a-z] [A-Z])
  case "${os}" in
    CYGWIN*)
      operatingSystem="cygwin"
      ;;
    LINUX*)
      operatingSystem="linux"
      ;;
    MINGW*)
      operatingSystem="mingw"
      ;;
  esac
  echo "operatingSystem=${operatingSystem} (used to check for Cygwin and filemode compatibility)"
}

# Check the source files for issues:
# - the main issue is internal links need to use [](file.md), not [](file)
checkSourceDocs() {
  # Currently don't do anything but could check the above.
  # Need one line to not cause an error.
  :
}

# Get the version modifier:
# - for example, from "12.00.00dev", "12.00.00 dev", 12.00.00beta", or "12.00.00 beta"
# - the first function argument is the full version, possibly including a space
# - the modifier is echoed, so capture by assigning in the calling code
getVersionModifier() {
  local fullVersion
  fullVersion="$1"
  # grep will print each found character on a separate line so concatenate output.
  modifier=$(echo ${fullVersion} | grep -o -E '[[:alpha:]]' | tr -d '\n' | tr -d ' ')
  echo ${modifier}
}

# Parse the command parameters.
parseCommandLine() {
  local d h l opt
  while getopts :dhl opt; do
    #echo "Command line option is ${opt}"
    case ${opt} in
      d) # Indicate that this should be copied to the latest release and version.
        dryrun="-n"
        ;;
      h) # Usage.
        printUsage
        exit 0
        ;;
      l) # Indicate that this should be copied to the latest release and version.
        copyToLatest="yes"
        ;;
      \?)
        echo "Invalid option:  -${OPTARG}" >&2
        exit 1
        ;;
      :)
        echo "Option -${OPTARG} requires an argument" >&2
        exit 1
        ;;
    esac
  done
}

# Print the usage.
printUsage() {
  echo ""
  echo "Usage:  $0"
  echo ""
  echo "Copy the site files to the latest website folder if -l specified:  ${gsFolderLatest}"
  echo "Copy the site files to the versioned website folder:  ${gsFolderVersion}"
  echo ""
  echo "-d dry run (print actions but don't execute upload)"
  echo "-h print usage"
  echo "-l copy to latest folder in addition to auto-detected version folder"
  echo ""
}

# Sync files to GCP.
syncFiles() {
  cd ${scriptFolder}

  # Now sync the local files up to Google Cloud:
  # - the -m option causes operations to run in parallel, which can be much faster
  # - the -d option means delete extra files in destination
  # - the -r option means recursive to sync the whole folder tree
  # For now always upload to the versioned copy.
  echo ""
  echo "Copying the documentation to the versioned folder:"
  echo "  from: ${siteFolder}"
  echo "    to: ${gsFolderVersion}"
  read -p "Continue with upload (Y/n)? " answer
  if [ -z "${answer}" -o "${answer}" = "Y" -o "${answer}" = "y" ]; then
    # Continue with copy to versioned folder.
    gsutil -m rsync -d -r ${dryrun} $siteFolder ${gsFolderVersion}
    exitStat=$?
    if [ ${exitStat} -ne 0 ]; then
      return ${exitStat}
    fi
    if [ ${copyToLatest} = "yes" ]; then
      # Also copy the latest.
      echo ""
      echo 'Copying the documentation to the "latest" folder:'
      echo "  from: ${siteFolder}"
      echo "    to: ${gsFolderLatest}"
      read -p "Continue with upload (Y/n)? " answer
      if [ -z "${answer}" -o "${answer}" = "Y" -o "${answer}" = "y" ]; then
        gsutil.cmd -m rsync -d -r ${dryrun} $siteFolder ${gsFolderLatest}
        exitStat=$?
        return ${exitStat}
      fi
    else
      echo ""
      echo 'Remember to run with -l option to also upload to the "latest" folder.'
      echo ""
    fi
  fi
}

# Main entry point into script.

# Check the operating system.
checkOperatingSystem

# Make sure the MkDocs version is OK.
checkMkdocsVersion

# Check the source files for issues.
checkSourceDocs

# Get the folder where this script is located since it may have been run from any folder.
scriptFolder=$(cd $(dirname "$0") && pwd)
# Change to the folder where the script is since other actions below are relative to that.
cd ${scriptFolder}

gitRepoFolder=$(dirname "${scriptFolder}")
gitReposFolder=$(dirname "${gitRepoFolder}")
mkdocsProjectFolder=${gitRepoFolder}/mkdocs-project
siteFolder=${mkdocsProjectFolder}/site
projectFolder="${gitReposFolder}/cdss-app-statecu-fortran"
srcFolder="${projectFolder}/src"
srcMainFolder="${srcFolder}/main/fortran"
gcommonFile="${srcMainFolder}/gcommon.inc"
if [ -f "${gcommonFile}" ]; then
  statecuVersion=$(cat ${gcommonFile} | grep 'PARAMETER' | grep 'VERS' | cut -d '=' -f 2 | tr -d ' ' | tr -d ')' | tr -d "'")
  statecuModifierVersion=$(getVersionModifier "${statecuVersion}")
else
  echo "Cannot determine StateCU version because file not found:"
  echo "  ${gcommonFile}"
  exit 1
fi
if [ -z "${statecuVersion}" ]; then
  echo "Cannot determine StateCU version by scanning:"
  echo "  ${gcommonFile}"
  exit 1
fi
echo "scriptFolder=${scriptFolder}"
echo "gitRepoFolder=$gitRepoFolder}"
echo "gitReposFolder=${gitReposFolder}"
echo "mkdocsProjectFolder=${mkdocsProjectFolder}"
echo "projectFolder=${projectFolder}"
echo "srcFolder=${srcFolder}"
echo "srcMainFolder=${srcMainFolder}"
echo "gcommonFile=${gcommonFile}"
echo "statecuVersion=${statecuVersion}"

# Set --dryrun to test before actually doing.
dryrun=""
gsFolderLatest="gs://opencdss.state.co.us/statecu/latest/doc-user"
gsFolderVersion="gs://opencdss.state.co.us/statecu/${statecuVersion}/doc-user"

# Whether to copy to latest in addition to the specific version:
# - default to no because the script can be run on any version, and can't assume latest
copyToLatest="no"

# Parse the command line.
parseCommandLine $@

if [ ! -z "${statecuVersionModifier}" -a "${copyToLatest}" = "yes" ]; then
  # The version contains "dev" or "beta" so don't allow to be used for "latest".
  echo "StateCU version ${statecuVersion} contains modifier - not copying to latest."
  copyToLatest="no"
fi

# First build the site so that the "site" folder contains current content:
# - "mkdocs serve" does not do this
buildMkDocsSite

# Sync the files to the cloud.
syncFiles

exit $?
