#!/bin/bash

if [ -z "$CPHP_PR_ID"]
then
  appName=EphemeralDrupalDemo
else
  appName=EphemeralDrupalDemo-$CPHP_PR_ID
fi

aws --profile $Profile \
  s3 cp $PACKAGE_PATH s3://$PackageBucket/$CPHP_GIT_COMMIT.tar.gz

deploymentId=`aws --region $Region --profile $Profile \
  deploy create-deployment \
    --application-name $appName \
    --s3-location bucket=$PackageBucket,key=$CPHP_GIT_COMMIT.tar.gz,bundleType=tgz \
    --deployment-group-name app \
    --description "Deployment app related to commit $CPHP_GIT_COMMIT" \
  --query 'deploymentId' --output text`

echo "Deployment start with ID $deploymentId"

aws --profile $Profile --region $Region \
  deploy wait deployment-successful \
    --deployment-id $deploymentId
