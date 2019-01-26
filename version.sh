aws elasticbeanstalk create-application-version --application-name target-app \
    --version-label $(date +%F)-$(git rev-parse HEAD)  \
    --source-bundle S3Bucket="cakedisk-api",S3Key="deploy.zip" \
    --no-auto-create-application
