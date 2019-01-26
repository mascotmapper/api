#!/bin/bash
environment=${1:-staging}
application=target-app
tag=$(date +%F)-$(git rev-parse --short HEAD)

function get_status() {
    echo $(aws elasticbeanstalk describe-environment-health --environment-name ${environment} --attribute-names Status --query="Status")
}

status=$(get_status)

if [ $status != '"Ready"' ];
then
    echo "Unexpected status before deployment: ${status}"
    exit 1
fi

aws elasticbeanstalk update-environment \
    --application-name ${application} \
    --environment-name ${environment} \
    --version-label ${tag}

count=0

while [ $status == '"Ready"' ] || [ $count -eq 30 ];
do
    count=$(( $count + 1))
    status=$(get_status);
    sleep 10;
done

count=0

until [ $status == '"Ready"' ] || [ $count -eq 30 ];
do
    count=$(( $count + 1))
    status=$(get_status);
    echo "count=${count}; status=${status}"
    sleep 10;
done

if [ $count -eq 30 ];
then
    echo "Something went wrong. :/"
    exit 1
fi
