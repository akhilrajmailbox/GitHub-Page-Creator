#!/bin/bash


function Readme_Provider() {

    export READMEFILE=""
    while [[ ${READMEFILE} == "" ]] ; do
        echo "READMEFILE is empty"
        read -r -p "enter the README.md file raw url :: " READMEFILE </dev/tty
        export READMEFILE=${READMEFILE}
    done
}


function Html_Provider() {

    export HTML_FILE_NAME=""
    while [[ ${HTML_FILE_NAME} == "" ]] ; do
        echo "HTML_FILE_NAME is empty"
        read -r -p "enter the html file name you want to serve :: " HTML_FILE_NAME </dev/tty
        export HTML_FILE_NAME=${HTML_FILE_NAME}
    done
}


function page() {

    Readme_Provider
    Html_Provider

    if [[ ! -d /opt/mount ]] ; then
        mkdir /opt/mount
    fi

    if [[ ! -z ${READMEFILE} ]] && [[ ! -z ${HTML_FILE_NAME} ]] ; then
        export P_W_D=${PWD} ; cd /opt/
        wget ${READMEFILE} -O ${HTML_FILE_NAME}
        echo -e "Creating html file from READMEFILE : ${READMEFILE}"
        local HTML_FILE_NAME=${HTML_FILE_NAME}
        local DEST_FILE_NAME=$(basename ${HTML_FILE_NAME}).html
        local DEST_FILE_NAME=/opt/mount/${DEST_FILE_NAME}
        if [[ -f ${DEST_FILE_NAME} ]] ; then
            echo -e "${DEST_FILE_NAME} already present...! \n task aborting...!"
            exit 1
        else
            local CSS_VALUE=$(cat /opt/reference-index | head -1)
            echo -e "\n Env Values :\n"
            echo HTML_FILE_NAME=${HTML_FILE_NAME}
            echo DEST_FILE_NAME=${DEST_FILE_NAME}
            echo CSS_VALUE=${CSS_VALUE}
            node generateReadMe.js
            echo ${CSS_VALUE} >> ${DEST_FILE_NAME}
            ls ${DEST_FILE_NAME}
        fi
        cd ${P_W_D}
    else
        echo -e "\n READMEFILE or HTML_FILE_NAME not found..! task aborting..! \n"
        exit 1
    fi
}

page