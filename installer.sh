#!/bin/bash

function print_stratis_logo {
	base64 -d <<<H4sIAApMMWYAA31QWwoDIRD79xT56y4UvJCQHiSHbyaztYWWDuKYx0QRoAvw+ijizbAN3zUwS5Qg2s1ehQ6emVGm1fmXHsqzq9qSkXAjHfVAo5k9qT6WZ+vBIxFnHPHhuPyqVKzcW2w8W/fUHHax0la9y5z7nWoU4cVybh2lU+PXJ/yrDuy/egIijh69aAEAAA== | gunzip
	echo "Medical Physics Department, Memorial Sloan Kettering Cancer Center, New York, NY"
	echo " " 
}

N_MODELS=2

function define_models {
	N=$1
	case ${N} in
	   1) 
		MODEL_NAME=CT_cardiac_structures_deeplab
		;;
	   2)
		MODEL_NAME=CT_Lung_SMIT
	  	;;
#	   3) 
#		MODEL_NAME=CT_Brain_SMIT
#		MODEL_GIT="NONE"
#               MODEL_WEIGHTS="NONE"
#		CONDAPACK_HASH="NONE"
#	  	;;
#	   4)
#		MODEL_NAME=CT_HeadAndNeck_SelfAttention
#		MODEL_GIT="NONE"
#               MODEL_WEIGHTS="NONE"
#		CONDAPACK_HASH="NONE"
#		;;
	   *)
		echo Error
		;;
	esac

	echo $MODEL_NAME ${MODEL_GIT} ${MODEL_WEIGHTS} ${CONDAPACK}
}

function print_model_opts {
	N_MODELS=2
        echo "The following are the list of available models. When passing the argument to installer, select the number of the model to download: "
	for N in `seq 1 ${N_MODELS}`
	do
		echo "          	${N}.  `define_models ${N}`"
	done
}

function help_text {
	echo "Usage Information: "
	echo "	Flags: "
	echo "		-i : Flag to run installer in interactive mode (no argument)"
	echo "		-m : [1-2] Integer number to select model to install. For list of available options, see below. "
	echo "		-d : Directory to install model with network weights "
	echo "		-p : [P/C/N] Setup and install Python environment P:Conda env from YAML; C: Conda pack download; N: No install. " #User must already have Anaconda installed and initiated. "
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
MODEL_NUM=1
MODEL_NAME="NONE"
INSTALLDIR="$HOME"
POPTION="N"


# parse input arguments
while getopts ":hm:d:ip:" opt; do
  case $opt in
    h)
	help_text
	exit 0
      ;;
    m)
    MODEL_NUM=${OPTARG}
	MODEL_NAME=`define_models ${MODEL_NUM}`
	if [ "${MODEL_NAME}" == "Error" ]; then MODEL_NUM="NONE"; fi
      ;;
    d)
        INSTALLDIR=${OPTARG}
      ;;
    p)
	POPTION=${OPTARG}
	if [[ "${POPTION}" != "P" && "${POPTION}" != "C" && "${POPTION}" != "N" ]]; then POPTION="N"; echo "Selected -p Python option invalid, defaulting to N"; fi
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
	echo "Press Ctrl-C at any time to exit"
	echo " " 

	echo "Step 1. Model Selection"
	echo "***********************"
	echo " " 

	print_model_opts		

	echo "Please select model to install on local machine [${MODEL_NUM}]: "

	read USR_ANS

	if [ "${USR_ANS}" != "" ]; then MODEL_NUM=${USR_ANS}; fi

	#MODEL_STRING=`define_models ${MODEL_NUM}`
	MODEL_NAME=`echo ${MODEL_STRING} | awk '{ print $1 }'`
	#MODEL_GIT_HASH=`echo ${MODEL_STRING} | awk '{ print $2 }'`
	#MODEL_WEIGHTS_HASH=`echo ${MODEL_STRING} | awk '{ print $3 }'`
	#CONDAPACK_HASH=`echo ${MODEL_STRING} | awk '{ print $4 }'`

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
	echo "Please select the option indicate if the installer should create the Python environment [${POPTION}]: " # [${PYSETUP}]: "
	echo "	P : Set up Conda environment from included YAML file"
	echo "  C : Download Conda-Pack environment"
	echo "  N : No Python setup"

	read USR_ANS
	
	if [ "${USR_ANS}" != "" ]
	then
		if [[ "${USR_ANS}" != "P" &&  ${USR_ANS} != "C" && "${USR_ANS}" != "N" ]]; then POPTION=N; else POPTION=${USR_ANS}; fi
	fi

	echo "Python setup option selected is ${POPTION}"


	echo "Proceeding with installation and setup"
	
else
	#MODEL_STRING=`define_models ${MODEL_NUM}`
    MODEL_NAME=`define_models ${MODEL_NUM}`
    #MODEL_GIT_HASH=`echo ${MODEL_STRING} | awk '{ print $2 }'`
    #MODEL_WEIGHTS_HASH=`echo ${MODEL_STRING} | awk '{ print $3 }'`
    #CONDAPACK_HASH=`echo ${MODEL_STRING} | awk '{ print $4 }'`
fi

# Verify all selected options

# Commence with install

# Option 1: Install cardiac substructures DeepLab
if [ "${MODEL_NUM}" == "1" ]
then
	cd ${INSTALLDIR}
	#MODEL_GIT=`base64 -d <<<${MODEL_GIT_HASH} | gunzip`
	MODEL_GIT="https://github.com/cerr/${MODEL_NAME}.git"
	echo git clone ${MODEL_GIT}
	git clone ${MODEL_GIT}

	#MODEL_FOLDER=`basename ${MODEL_GIT} | sed "s/.git//g"`
	MODEL_PATH=${INSTALLDIR}/${MODEL_NAME}
	echo cd ${MODEL_PATH}
	cd ${MODEL_PATH}

	MODEL_WEIGHTS_HASH=`cat model.txt | grep MODEL_WEIGHTS | awk '{ print $2 }'`
	CONDAPACK_HASH=`cat model.txt | grep CONDAPACK | awk '{ print $2 }'`

	MODEL_WEIGHTS=`base64 -d <<<${MODEL_WEIGHTS_HASH} | gunzip`
	echo wget -O model_weights.tar.gz -L ${MODEL_WEIGHTS}
	wget -O model_weights.tar.gz -L ${MODEL_WEIGHTS}	
	echo tar xf model_weights.tar.gz	
	tar xf model_weights.tar.gz

	if [ "${POPTION}" == "C" ]
	then 
		#download conda-pack
		mkdir ${MODEL_PATH}/conda-pack
		cd ${MODEL_PATH}/conda-pack
		CONDAPACK=`base64 -d <<<${CONDAPACK_HASH} | gunzip`
		echo wget -O condapack.tar.gz -L ${CONDAPACK}
		wget -O condapack.tar.gz -L ${CONDAPACK}
		echo tar xf condapack.tar.gz
		tar xf condapack.tar.gz
	elif [ "${POPTION}" == "P" ]
	then
		#set up Conda environment
                CONDAHOME=`conda info | grep "base environment" | awk '{ print $4 }'`
                if [ -z "${CONDAHOME}" ]
                then
                        echo "Anaconda may not be installed; python setup cannot continue"
			echo "Exiting."
                        exit 1
                fi
		conda create -y --name ${MODEL_NAME} python=3.8

		source ${CONDAHOME}/etc/profile.d/conda.sh

		conda activate ${MODEL_NAME}
		pip install -r requirements.txt
	fi
fi


# Option 2: Install CT_Lung_SMIT
#if [ "${MODEL_NUM}" == "2"] 
#then
#
#fi
