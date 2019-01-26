aws elasticbeanstalk update-environment --application-name target-app \
    --environment-name staging \
    --version-label $(date +%F)-$(git rev-parse HEAD)
