# Drupal Ephemeral AWS Infrastructure Deployment

## Requirements

You need an [AWS account](https://portal.aws.amazon.com/billing/signup#/start)  
Install Pyhton 3.7 And [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)  
Configure AWS CLI documentation [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
install make

## Deploy Infrastructure

### Configure your AWS Accout

To deploy this stack you need to create some component manually.  
First, you need a [S3 Bucket](https://docs.aws.amazon.com/quickstarts/latest/s3backup/step-1-create-bucket.html)  
On EC2 service, you need to create a [key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) to access to your server thought SSH  
Configure a [public hosted zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html)
Create a role for [cloudformation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-servicerole.html)

### Environment variables

export Profile=<your aws profile name>
export InfraBucket=<your S3 bucket>
export PackageBucket=<your S3 bucket or an other as you wish>
export BaseDomain=<your public hosted zone domain name>
export KeyPair=<your key pair name>
export RoleArn=<cloudformation role arn>
export Region=<AWS favorite region code>

### Deploy you stack

```bash

cd infra
make deploy

```

## Deploy Drupal

### Define yours drupal parameters

Your code will be deployed using AWS CodeDeploy  
  
Prepare the package running : composer --no-dev  
Prepare your durpal configuration  
  
Prepare a tar.gz package.  
  
run deployement :  
  
```bash

export version=<My destination package version>
export PACKAGE_PATH=<local package location>

aws --profile $Profile \
  s3 cp $PACKAGE_PATH s3://$PackageBucket/$version.tar.gz

deploymentId=`aws --region $Region --profile $Profile \
  deploy create-deployment \
    --application-name $appName \
    --s3-location bucket=$PackageBucket,key=$version.tar.gz,bundleType=tgz \
    --deployment-group-name app \
    --description "Deployment app related to commit $version" \
  --query 'deploymentId' --output text`

echo "Deployment start with ID $deploymentId"

aws --profile $Profile --region $Region \
  deploy wait deployment-successful \
    --deployment-id $deploymentId

```
  
Or Use deploy.sh in [continuousphp.com](https://app.continuousphp.com)

TEST DEPLOY PR
