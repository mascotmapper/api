aws elasticbeanstalk create-application-version --application-name target-app \
    --version-label $(date +%F-%s)  \
    --source-bundle S3Bucket="cakedisk-api",S3Key="deploy.zip" \
    --no-auto-create-application
