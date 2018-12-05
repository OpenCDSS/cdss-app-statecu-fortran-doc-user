# StateCU Documentation #

This documentation is the user manual for Colorado's Decision Support Systems (CDSS) StateCU consumptive use model software.

StateCU was developed to estimate and report crop consumptive use.
It consists of a Fortran computer program and an associated graphical user interface.
The crop consumptive use methods employed in the program and the interface are the Modified Blaney-Criddle,
the Original Blaney-Criddle, and the Pochop (for bluegrass only) methods
with calculations on a monthly basis and the ASCE Standardized Penman-Monteith method with
calculations on a daily basis. Other crop consumptive use methods available when the Fortran program
is operated independently of the interface include the Penman-Monteith and the Modified Hargreaves
methods, operated on a daily time step.

**This documentation is a work in progress, with the initial online version including references to the existing PDF format.**

This documentation page includes the following sections:

* [How to Use this Documentation](#how-to-use-this-documentation) - guidance and list of main documentation sections
* [Colorado's Decision Support Systems (CDSS)](#colorados-decision-support-systems-cdss) - the system under which the software is maintained
* [License](#license) - license for software and this documentation
* [Source Repository on GitHub](#source-repository-on-github) - location of StateCU repository in GitHub

------------

## How to Use this Documentation ##

This documentation is the user documentation for the StateCU software.
Most of the documentation currently consist of the legacy Word/PDF documentation. 
The legacy documentation may be fully converted to online navigable form at some point.

Use the navigation menu on the left to select pages and the navigation menu on the right
to select sections within a page.
The navigation menus may be collapsed if viewing in a narrow window or mobile device.

* See the [Full legacy documentation as PDF](legacy/StateCU Version 13.10 Documentation.pdf) (note that the links work
but ***Back*** may return to this page).

## Colorado's Decision Support Systems (CDSS) ##

Colorado's Decision Support Systems (CDSS, [cdss.state.co.us](http://cdss.state.co.us))
has been developed to answer important questions about Colorado's water resources.
CDSS efforts are led by the [Colorado Water Conservation Board (CWCB)](http://cwcb.state.co.us)
and [Colorado Division of Water Resources (DWR)](http://water.state.co.us).

![CDSS Website](index-images/CDSS-website.png)

One component of CDSS is the StateCU consumptive use model.

In late 2016, the CWCB funded the OpenCDSS project to move StateCU and other CDSS software to open source licensing
and establish open source software projects.
The [Open Water Foundation](http://openwaterfoundation.org) was contracted to lead the OpenCDSS project.

## License ##

The license for this documentation is the [Creative Commons CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).

The license for StateCU software is the GPL v3 license.

## Source Repository on GitHub ##

The source files for this documentation are maintained in the public GitHub repository for StateCU: [cdss-app-statecu-fortran-doc-user](https://github.com/OpenCDSS/cdss-app-statecu-fortran-doc-user).
Documentation website files currently are copied to the Open Water Foundation [Learn / CDSS StateCU](http://learn.openwaterfoundation.org/cdss-app-statecu-fortran-doc-user/) website,
and will be copied to an OpenCDSS website in the future.

## Release Notes ##

Release notes for StateCU and this documentation will be implemented as the open source migration is finalized.
