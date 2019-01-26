#!/bin/sh
application=target-app
bucket=cakedisk-api
tag=$(date +%F)-$(git rev-parse --short HEAD)
bundle=bundle-${tag}.zip

zip -r /tmp/${bundle} . -x ".git*"
aws s3 cp /tmp/${bundle} s3://${bucket}
aws elasticbeanstalk create-application-version \
    --application-name ${application} \
    --version-label ${tag}  \
    --source-bundle S3Bucket="cakedisk-api",S3Key="${bundle}" \
    --no-auto-create-application
