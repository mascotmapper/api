#!/bin/bash
environment=${1}
application=target-app
tag=$(date +%F)-$(git rev-parse HEAD)

function get_status() {
    echo $(aws elasticbeanstalk describe-environment-health --environment-name ${environment} --attribute-names HealthStatus --query="HealthStatus")
}

status=$(get_status)

if [ $status != '"Ok"' ];
then
    echo "Unexpected status: ${status}"
    exit 1
fi

aws elasticbeanstalk update-environment \
    --application-name ${application} \
    --environment-name ${environment} \
    --version-label ${tag}

while [ $status == '"Ok"' ];
do
    status=$(get_status);
    echo $status
    sleep 10;
done

until [ $status == '"Ok"' ];
do
    status=$(get_status);
    echo $status
    sleep 10;
done
