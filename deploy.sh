#!/bin/sh
environment=${1}
application=target-app
tag=$(date +%F)-$(git rev-parse HEAD)

aws elasticbeanstalk update-environment \
    --application-name ${application} \
    --environment-name ${environment} \
    --version-label ${tag}
