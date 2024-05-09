#!/bin/bash

function print_stratis_logo {
	base64 -d <<<H4sIAApMMWYAA31QWwoDIRD79xT56y4UvJCQHiSHbyaztYWWDuKYx0QRoAvw+ijizbAN3zUwS5Qg2s1ehQ6emVGm1fmXHsqzq9qSkXAjHfVAo5k9qT6WZ+vBIxFnHPHhuPyqVKzcW2w8W/fUHHax0la9y5z7nWoU4cVybh2lU+PXJ/yrDuy/egIijh69aAEAAA== | gunzip
	echo "Medical Physics Department, Memorial Sloan Kettering Cancer Center, New York, NY"
	echo " " 
}

function define_models {
	N=$1
	case ${N} in
	   1) 
		MODELNAME=CT_cardiac_structures_deeplab
		MODELGIT=H4sIAE2qOWYAA8soKSkottLXT88syShN0kvOz9VPTi0q0ncOiU9OLErJTEyOLy4pKk0uKS1KLY5PSU0tyElM4gIACCFhTTYAAAA=
		MODELWEIGHTS=H4sIAF6rOWYAAwXBUQ6AIAgA0P8OI3P9VLchQnGmtMDWOn3viftlG0CzShR2fQNpAxO8+QBz9EIgfZlTbCPjitxFlStHf+pIquUkD/mbfnx+XzlIAAAA
		;;
	   2)
		MODELNAME=CT_Lung_SMIT
		MODELGIT=""
		MODELWEIGHTS=""
	  	;;
	   3) 
		MODELNAME=CT_Brain_SMIT
		MODELGIT=""
                MODELWEIGHTS=""
	  	;;
	   4)
		MODELNAME=CT_HeadAndNeck_SelfAttention
		MODELGIT=""
                MODELWEIGHTS=""
		;;
	   *)
		echo Error
		;;
	esac

	echo $MODELNAME `base64 -d <<<${MODELGIT} | gunzip` `base64 -d <<<${MODELWEIGHTS}`
}

function print_model_opts {
        echo "The following are the list of available models. When passing the argument to installer, select the number of the model to download: "
	for N in `seq 1 4`
	do
		echo "          	${N}.  `define_models ${N} | awk '{ print $1 }'`"
	done
}

function help_text {
	echo "Usage Information: "
	echo "	Flags: "
	echo "		-i : Flag to run installer in interactive mode (no argument)"
	echo "		-m : [1-4] Integer number to select model to install. For list of available options, see below. "
	echo "		-d : Directory to install model with network weights "
	echo "		-p : [Y/N] Setup and install Anaconda environment to run model from environment.yml. User must already have Anaconda installed and initiated. "
	echo "		-h : Print help menu "
	echo " "
	print_model_opts
}

function intro_text {
	echo "Welcome to the Stratis-Forge segmentation model installer! For usage information, run with -h flag"
	echo " "
}


print_stratis_logo
intro_text


#Initialize default options
IMODE=0
MODELTARG=""
INSTALLDIR="$HOME"
PYSETUP="N"


# parse input arguments
while getopts ":hm:d:ip:" opt; do
  case $opt in
    h)
	help_text
	exit 0
      ;;
    m)
        MODEL_NUM=${OPTARG}
	MODEL_STRING=`define_models ${MODEL_NUM}`
	MODEL_NAME=`echo ${MODEL_STRING} | awk '{ print $1 }'`
	if [ "${MODELNAME}" == "Error" ]; then MODELTARG=""; fi
      ;;
    d)
        INSTALLDIR=${OPTARG}
      ;;
    p)
	PYSETUP=${OPTARG}
	if [[ "${PYSETUP}" != "Y" && "${PYSETUP}" != "N" ]]; then PYSETUP=N; fi
      ;;
    i)
	IMODE=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
       ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done



# Interactive Mode
if [ "$IMODE" == "1" ]
then
	echo "Interactive installation mode selected."
	echo "======================================="

	echo " " 
	echo "Step 1. Model Selection"
	echo "***********************"
	echo " " 

	print_model_opts		

	echo "Please select model to install on local machine [${MODEL_NUM}]: "

	read USR_ANS

	if [ "${USR_ANS}" != "" ]; then MODEL_NUM=${USR_ANS}; fi

	MODEL_NAME=`define_models ${MODEL_NUM} | awk '{ print $1 }'`

	if [ "${MODEL_NAME}" != "Error" ]
	then 
		echo "Model selected is ${MODEL_NUM}. ${MODEL_NAME}"
	else
		echo "Error, no valid model selected [${MODEL_NUM}]"
		exit 1
	fi

	echo " " 
	

	echo "Step 2. Installation Directory"
	echo "******************************"
	echo " "
	echo "Please specify installation directory [${INSTALLDIR}]: " 

	read USR_ANS
	
	if [ "${USR_ANS}" != "" ]; then ${INSTALLDIR}=${USR_ANS}; fi

	echo "Installation directory selected is ${INSTALLDIR}"

	echo " "

	echo "Step 3. Python Option"
	echo "*********************"
	echo " " 
	echo "Please indicate if the installer should create the Conda environment [${PYSETUP}]: "

	read USR_ANS
	
	if [ "${USR_ANS}" != "" ]
	then
		if [ "${PYSETUP}" != "Y" && "${PYSETUP}" != "N" ]; then PYSETUP=N; fi
	fi

	echo "Conda env setup option selected is ${PYSETUP}"

	echo "Proceeding with installation and setup"
	
fi

# Verify all selected options

# Commence with install
