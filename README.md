# Stratis-Forge Model Installer

Locally set up and install network weights, scripts and (optionally) Conda environments for running image segmentation.

```
      ___           ___           ___           ___
     /  /\         /  /\         /  /\         /  /\
    /  /:/        /  /:/_       /  /::\       /  /::\
   /  /:/        /  /:/ /\     /  /:/\:\     /  /:/\:\
  /  /:/  ___   /  /:/ /:/_   /  /:/~/:/    /  /:/~/:/
 /__/:/  /  /\ /__/:/ /:/ /\ /__/:/ /:/___ /__/:/ /:/___
 \  \:\ /  /:/ \  \:\/:/ /:/ \  \:\/:::::/ \  \:\/:::::/
  \  \:\  /:/   \  \::/ /:/   \  \::/~~~~   \  \::/~~~~
   \  \:\/:/     \  \:\/:/     \  \:\        \  \:\
    \  \::/       \  \::/       \  \:\        \  \:\
     \__\/         \__\/         \__\/         \__\/

Medical Physics Department, Memorial Sloan Kettering Cancer Center, New York, NY

Welcome to the CERR segmentation model installer! For usage information, run with -h flag

Welcome to the Stratis-Forge segmentation model installer! For usage information, run with -h flag

Usage Information:
        Flags:
                -i : Flag to run installer in interactive mode (no argument)
                -m : [1-2] Integer number to select model to install. For list of available options, see below.
                -d : Directory to install model with network weights
                -p : [P/C/N] Setup and install Python environment P:Conda env from YAML; C: Conda pack download; N: No install.
                -h : Print help menu

The following are the list of available models. When passing the argument to installer, select the number of the model to download:
                1.  CT_cardiac_structures_deeplab
                2.  CT_Lung_SMIT
```
