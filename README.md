# cdss-app-statecu-fortran-doc-user #

This repository contains [Colorado's Decision Support Systems (CDSS)](https://www.colorado.gov/cdss) StateCU user documentation.
See the following online resources:

*   [OpenCDSS Documentation](http://opencdss.state.co.us/opencdss/)
*   [StateCU User Documentation](http://opencdss.state.co.us/statecu/latest/doc-user/)

This page contains the following sections:

*   [Repository Contents](#repository-contents)
*   [Development Environment](#development-environment)
*   [Editing and Viewing Content](#editing-and-viewing-content)
*   [Style Guide](#style-guide)
*   [License](#license)
*   [Contributing](#contributing)
*   [Maintainers](#maintainers)
*   [Release Notes](#release-notes)

-----------------

## Repository Contents ##

The repository contains the following:

```text
cdss-app-statecu-fortran-doc-user/   Repository name and main folder should match.
  build-util/                        Useful scripts to view, build, and deploy documentation.
  mkdocs-project/                    Typical MkDocs project for this documentation.
    mkdocs.yml                       MkDocs configuration file for website.
    docs/                            Folder containing source Markdown and other files for website.
    site/                            Folder created by MkDocs containing the static website - ignored using .gitignore.
  .github/                           Files specific to GitHub such as issue template.
  .gitattributes                     Typical Git configuration file for repository attributes.
  .gitignore                         Typical Git configuration file for ignored file list.
  README.md                          This file.

```

The following folder structure is recommended for StateCU development.
Top-level folders should be created as necessary.
Repositories are expected to be on the same folder level to allow scripts in those repositories to work.

```
C:\Users\user\                              Windows user home folder.
/c/Users/user/                              Git Bash user home folder that overlaps Windows files.
/home/user/                                 Linux user home folder.
/cygdrive/C/Users/user/                     Cygwin user home folder that overlaps Windows files.
  cdss-dev/                                 Projects that are part of Colorado's Decision Support Systems.
    StateCU/                                StateCU product folder.
------------- folder names below must match --------------
      git-repos/                            Git repositories for StateCU.
        cdss-app-statecu-fortran/           StateCU source code development.
        cdss-app-statecu-fortran-doc-user/  StateCU user documentation.
        cdss-app-statecu-fortran-test/      StateCU automated tests.
```

## Development Environment ##

The development environment for contributing to this project requires installation of Python, MkDocs, and Material MkDocs theme.
Python 3 has been used for development.
See the [MkDocs website](https://www.mkdocs.org/) and
[OWF / Learn MkDocs](http://learn.openwaterfoundation.org/owf-learn-mkdocs/)
documentation for information about installing these tools.

Also install the following (assuming that Windows `py` Python is used with MkDocs):

*   `py -m pip install python-markdown-math`

## Editing and Viewing Content ##

If the development environment is properly configured, edit and view content as follows:

1.  Edit content:
    1.  The `mkdocs-project/docs` folder contains website content.
    2.  The `mkdocs-project/mkdocs.yml` file lists files to include in the website.
2.  Run the `build-util/run-mkdocs-serve-8000.sh` script (Git Bash, Cygwin, Linux).
3.  View content in a web browser using URL `http://localhost:8000`.

## Style Guide ##

The following are general style guide recommendations for this documentation,
with the goal of keeping formatting simple in favor of focusing on useful content:

*   Use the Material MkDocs theme - it looks nice, provides good navigation features, and enables search.
*   Follow MkDocs Markdown standards - use extensions beyond basic Markdown when useful.
*   Show files and program names as `code (tick-surrounded)` formatting.
*   Where a source file can be linked to in GitHub, provide a link so that the most current file can be viewed.
*   Use triple-tick formatting for code blocks, with language specifier.
*   Use ***bold italics*** when referencing UI components such as menus.
*   Use slashes to indicate ***Menu / SubMenu***.
*   Place images in an `images` folder or `contentpage-images` folder if need to separate images.
*   Minimize the use of inlined HTML, but use it where Markdown formatting is limited.
*   Although the Material them provides site and page navigation sidebars,
    provide in-line table of contents on pages, where appropriate, to facilitate review of page content.

## License ##

The license for this documentation is the
[Creative Commons Attribution 2-0 Generic (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/).

## Contributing ##

Contribute to the documentation as follows:

1.  Use GitHub repository issues to report minor issues.
2.  Use GitHub pull requests.

In order to contribute, you must first sign and submit the Contributor License Agreement (CLA).
**Need to add the link here to OpenCDSS web page that describes this.**

## Maintainers ##

This repository is maintained by the OpenCDSS team.

## Release Notes ##

The following release notes indicate major updates.
See the GitHub issues for details.

*   2023-04-20 - Updated documentation to fix broken links and remediate issues related to accessibility including alt text for images and heading structures.
*   2019-09-08 - Brian Macpherson ported full Word documentation for StateCU 13.10. 
*   2019-04-26 - Update to use opencdss.state.co.us. 
*   2019-03-23 - Update to MkDocs 1.04.
*   2018-12-04 - Initial repository - basic MkDocs project wrapping legacy Word/PDF documentation.
