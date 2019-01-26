#!/bin/bash
environment=${1:-staging}
application=target-app
tag=$(date +%F)-$(git rev-parse HEAD)

function get_status() {
    echo $(aws elasticbeanstalk describe-environment-health --environment-name ${environment} --attribute-names HealthStatus --query="HealthStatus")
}

status=$(get_status)

if [ $status != '"Ok"' ];
then
    echo "Unexpected status before deployment: ${status}"
    exit 1
fi

aws elasticbeanstalk update-environment \
    --application-name ${application} \
    --environment-name ${environment} \
    --version-label ${tag}

iteration=0

while [ $status == '"Ok"' ] || [ $iteration -eq 50 ];
do
    iteration=$(( $interation + 1))
    status=$(get_status);
    echo "iteration=${iteration}; status=${status}"
    sleep 10;
done

iteration=0

until [ $status == '"Ok"' ] || [ $iteration -eq 50 ];
do
    iteration=$(( $interation + 1))
    status=$(get_status);
    echo "iteration=${iteration}; status=${status}"
    sleep 10;
done
