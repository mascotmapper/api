aws elasticbeanstalk update-environment --application-name target-app \
    --environment-name production \
    --version-label $(date +%F)-$(git rev-parse HEAD)
