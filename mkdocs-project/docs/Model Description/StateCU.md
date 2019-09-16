This section discusses advanced modeling options that are currently supported by the FORTRAN
executable, but not yet supported by the StateCU GUI. Manipulation of individual input files, generally
through a text editor, is necessary to implement these modeling options. Once the files have been edited, the
StateCU scenarios can be simulated through the GUI or using the StateCU FORTRAN executable accessed
through a DOS command prompt. Note that if the scenario is simulated through the GUI, any additional
edits made through the GUI may overwrite the edits made externally.

Each section below provides a summary of the advanced modeling option and the revisions to specific input
files necessary to implement the option. 

###3.5.1 - Advanced Output Options ###

StateCU generates a large amount of output data for each model scenario, therefore StateCU allows
the user to manage the level of output information for each scenario. Many of these ‘levels’ of
output can be set through the StateCU GUI, as shown in [Section 2.5.2](../GUI/editmenu.md). There are additional output
options not available through the StateCU GUI that can be implemented by setting the __typout__
variable to select values in the Model Control File (\*ccu), as indicated in [Section 4.4](../Input Description/44.md). The
following summarizes these output options:

* _Typout = 5_ provides the same output information as _Typout = 3_, plus a Detailed Water
Budget by Land Category summary (\*.4wb) for all structures in the scenario. Note that
depending on the scenario size, this generates a significantly large output file. If
information is required for only a handful of structures, use the _Typout = 4_ option available
through the GUI.
* _Typout=11_ provides the same output information as _Typout = 1_, plus includes Scenario
Totals and Water District Totals in the binary output (\*.bd1)
* _Typout=12_ provides the same output information _Typout = 2_, plus includes Scenario Totals
and Water District Totals in the binary output (\*.bd1)
* _Typout=13_ provides the same output information _Typout = 3_, plus includes Scenario Totals
and Water District Totals in the binary output (\*.bd1)
* _Typout=14_ provides the same output information _Typout = 4_, plus includes Scenario Totals
and Water District Totals in the binary output (\*.bd1)
* _Typout=15_ provides the same output information _Typout = 5_, plus includes Scenario Totals
and Water District Totals in the binary output (\*.bd1) 

###3.5.2 - Deficit Irrigation ###

StateCU allows the user to estimate ground water diversions (pumping) to meet all or only a
portion of the remaining irrigation water requirement after available surface water diversions have 
been applied. The StateCU default is to estimate ground water diversions to meet all of the
remaining irrigation water requirement; ‘deficit irrigation’ occurs when ground water diversions are
estimated to meet only a portion of the remaining irrigation water requirement. The ‘deficit
irrigation’ model option is implemented by including a whole number percent (0 to 100) for the
__def_irr__ variable in the Model Control File (\*.ccu), as indicated in [Section 4.4](../Input Description/44.md). Note that when
__def_irr__ >0, the pumping reduction is only applied to structures with acreage served by ground
water as specified in the Irrigation Parameter Yearly file (\*.ipy) that have no historical pumping
specified in the Well Historic Pumping file (\*.pvh). 

###3.5.3 - Replacement Crop Requirement ###

StateCU allows the user to include an externally-developed crop requirement file for some or all
structures in a scenario that can be used in place of the StateCU-estimated crop requirement, as
discussed in [Section 4.29](../Input Description/429.md) and [Section 4.30](../Input Description/430.md). This modeling option allows the user to bypass the crop
consumptive use functionality in StateCU, while taking advantage of the water budget functionality
in StateCU. This option is implemented by including a monthly Replacement Crop Requirement
File (\*.rcr) with all structures in a scenario or a Partial Crop Requirement File (\*.pcr) with a
portion of the structures in a scenario, designated by the __Replacement_Crop_Requirement__ and
__Partial_Crop_Requirement__ variables in the Response File (\*.rcu). Although the crop
consumptive use functionality is bypassed when a replacement crop requirement file is included,
"dummy" placeholder files must be included in the response file for climate and crop files (e.g.
climate station file, temperature file, crop distribution file). Note that soil moisture parameters are
based on information in the crop distribution file (\*.cds) and care should be taken to reflect actual
crops in this placeholder file. 

###3.5.4 - Scenarios with Numerous Structures ###

The StateCU GUI has the capability to process scenarios with up to 900 structures, due to array
limitations in the VB.NET environment. The StateCU FORTRAN executable has the capability to
process scenarios up to 1,200 structures, although a warning that greater than 900 structures are
included will be printed in the log file. For scenarios with a very large number of structures, it is
recommended that the user simulate the scenario using the FORTRAN executable via a DOS
command line window. 