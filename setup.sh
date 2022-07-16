#!/bin/bash
#####
# this script will setup this project.
# run ./setup.sh to run this project.
#####
################ define functions ###############
function print_exit(){
    local error_code=${1}
    local error_msg=${2}
    echo ${error_msg}
    exit ${error_code}
}

function showBanner(){
    banner_file=${1}
    cat ${banner_file}
}

function installPackage() {
    local packageName=${1}
    if ! apt-get install -y ${packageName} > /dev/null
    then
        print_exit 1 "not able to install ${packageName}."
    fi
}

function mavenTarget(){
    local mavenCmd=${1}
    if ! mvn ${mavenCmd} > /dev/null
    then
        print_exit 1 "${mavenCmd} fail."
    fi
}

##### Variables. #################

if [[ $UID != 0 ]]
then
    print_exit 1 "user is not a root user"
fi

read -p "please enter access path " APP_CONTEXT
APP_CONTEXT=${APP_CONTEXT:-app}

if ! apt-get update > /dev/null
then
    print_exit 1 "not able to update the repository."
fi

showBanner banner.txt
installPackage maven
installPackage tomcat9
mavenTarget test
mavenTarget package

if cp -rf target/hello-world-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/${APP_CONTEXT}.war
then
    echo "application Deployed successfully. you can access it on http://{IPADDRESS}/${APP_CONTEXT}"
else
    print_exit 1 "not able to Deploy the application."
fi

# Clean Up code.

if rm -rf ./target
then
    echo "clean up successfull."
else
    echo "not able to do clean up."
fi

exit 0