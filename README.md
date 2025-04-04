# Refactoring of Typed Block Based Modeling Languages

This repository accompanies the research paper:

**"Refactoring with Confidence: An Assistant for Repair-Integrated Refactoring in Block-based Industrial Models"**

*LIT CPS Lab, JKU Linz, Austria*  https://www.jku.at/lit-cyber-physical-systems-lab/

## Overview

This project provides a **cross-language framework** and **toolset** for performing **repair-integrated refactoring** in **typed block-based modeling languages** (TBMLs), such as **IEC 61499** and **MATLAB Simulink**.
The implementation for refactoring matlab models can be found in 
```bash
tbml-refactoring/
├── matlab/impl                           # Refactoring Implementation of Matlab Simulink
├── matlab/example                        # Assembly line in Simulink with linked library
├── matlab/traces_before                  # Execution traces before the refactoring
├── matlab/traces_before                  # Execution traces after the refactoring
├── iec-61499/AssemblyLine                # Assembly line in IEC 61499 with library
├── iec-61499/AssemblyLine/traces_before  # Execution traces before the refactoring
├── iec-61499/AssemblyLine/traces         # Execution traces after the refactoring
```
To execute the Refactoring for Matlab Simulink is necessary to stat the sricpt matlab/impl/refactoring_main.m

To execute the Refactoring in IEC 61499 it is required to build  Eclipse 4diac https://github.com/eclipse-4diac with the following branch https://github.com/eclipse-4diac/4diac-ide/tree/3.0.x
