#!/bin/bash
#####
# this script will setup this project.
# run ./setup.sh to run this project.
#####
################ define functions ###############
function installPackage() {
    local packageName=${1}
    if ! apt-get install -y ${packageName}
    then
        echo "not able to install ${packageName}."
        exit 1
    fi
}

function mavenTarget(){
    local mavenCmd=${1}
    if ! mvn ${mavenCmd}
    then
        echo "${mavenCmd} fail."
        exit 1
    fi
}

##### Variables. #################

if [[ $UID != 0 ]]
then
    echo "user is not a root user"
    exit 1
fi

read -p "please enter access path " APP_CONTEXT
APP_CONTEXT=${APP_CONTEXT:-app}

if ! apt-get update
then
    echo "not able to update the repository."
    exit 1
fi

installPackage maven
installPackage tomcat9
mavenTarget test
mavenTarget package

if cp -rvf target/hello-world-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/${APP_CONTEXT}.war
then
    echo "application Deployed successfullu. you can access it on http://{IPADDRESS}/${APP_CONTEXT}"
else
    echo "not able to Deploy the application."
fi
exit 0