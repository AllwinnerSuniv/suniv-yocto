#!/bin/bash

# global variables
export NCPU=$(grep -c processor /proc/cpuinfo)
export CWD=$(pwd)
export RED_COLOR='\E[1;31m'   #红
export GREEN_COLOR='\E[1;32m' #绿
export YELOW_COLOR='\E[1;33m' #黄
export BLUE_COLOR='\E[1;34m'  #蓝
export PINK='\E[1;35m'        #粉红
export RES='\E[0m'

GIT=https://github.com
REMOTE=AllwinnerSuniv
UPSTREAM=${GIT}/${REMOTE}
RELEASE=thud

START_BUILD_TIME=$(date +%H:%M:%S)
LOGFILE=yocto_build_${START_BUILD_TIME}.log

function echo_warning() {
        echo -e "${YELOW_COLOR} [ $(date +%H:%M:%S) ]: $1 ${RES}"
}
export -f echo_warning

function echo_debug() {
        echo -e "${BLUE_COLOR} [ $(date +%H:%M:%S) ]: $1 ${RES}"
}
export -f echo_debug

function echo_error() {
        echo -e "${RED_COLOR} [ $(date +%H:%M:%S) ]: $1 ${RES}"
}
export -f echo_error

function echo_success() {
        echo -e "${GREEN_COLOR} [ $(date +%H:%M:%S) ]: $1 ${RES}"
}
export -f echo_success

# $1 repo ($2) repo url
function do_fetch() {
        if [ ! -d "$1/" ]; then
                echo $1 $2

                if [ -z "$2" ]; then
                        echo_debug "can't find $1, pulling from [${UPSTREAM}/${1}]:${RELEASE} ..."
                        git clone -q --depth 1 -b $RELEASE ${UPSTREAM}/$1
                else
                        echo_debug "can't find $1, pulling from [$2]:${RELEASE} ..."
                        git clone -q --depth 1 -b $RELEASE $2
                fi

        else
                echo_debug "$1/ was detected, make sure it's okay."
        fi
}

# check if a root user running this script
if [ "$(whoami)" = "root" ]; then
        echo_error "Should never run this script as root. Exiting..."
        exit -1
fi

# build the castle
BSPDIR=$CWD
export BSPDIR
# get into the real sources directory
if [ ! -d ${BSPDIR}/yocto ]; then
        mkdir -p ${BSPDIR}/yocto
fi

cd ${BSPDIR}/yocto

do_fetch poky

do_fetch meta-openembedded

do_fetch meta-suniv git@github.com:AllwinnerSuniv/meta-suniv.git

cd ${BSPDIR}

# pull layers we defined

# is there any patchs need to apply?

# create symbol links
ls yocto/meta-suniv/scripts/setup-environment.sh
ln -sf yocto/meta-suniv/scripts/setup-environment.sh ./setup-environment.sh

# setup
source ./setup-environment.sh

# show layers added to bitbake
bitbake-layers show-layers

echo_debug "bitbake building image ..."
bitbake suniv-lichee-image