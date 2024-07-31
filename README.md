# CERR Segmentation Model Installer

Locally set up and install network weights, scripts and (optionally) Conda environments for running AI-based image segmentation and registration models.

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

Usage Information:
        Flags:
                -i : Flag to run installer in interactive mode (no argument)
                -m : [1-7] Integer number to select model to install. For list of available options, see below.
                -d : Directory to install model with network weights
                -p : [P/C/N] Setup and install Python environment P: setup Conda env from python requirements.txt; C: Conda pack download; N: No install.
                -h : Print help menu

The following are the list of available models. When passing the argument to installer, select the number of the model to download:
                1.  CT_cardiac_structures_deeplab
                2.  CT_LungOAR_incrMRRN
                3.  MR_Prostate_Deeplab
                4.  CT_Lung_SMIT
                5.  MRI_Pancreas_Fullshot_AnatomicCtxShape
		6.  CT_HeadAndNeck_OARs
                7. CT_HN_SMIT
```
