#!/bin/sh
application=target-app
bucket=cakedisk-api
tag=$(date +%F)-$(git rev-parse --short HEAD)
bundle=bundle-${tag}.zip

mkdir -f ./bundles
zip -x .git* -x ./bundles -r ./bundles/${bundle} .
aws s3 cp ./bundles/${bundle} s3://${bucket}
aws elasticbeanstalk create-application-version \
    --application-name ${application} \
    --version-label ${tag}  \
    --source-bundle S3Bucket="cakedisk-api",S3Key="${bundle}" \
    --no-auto-create-application
