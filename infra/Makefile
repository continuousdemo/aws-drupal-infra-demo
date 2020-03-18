Profile?=continuous-demo-account
InfraBucket?=continuous-demo-cf
PackageBucket?=continuous-demo-cf
BaseDomain?=demo.continuous.team
StackName?=drupal-ephemeral-infra-$(PrId)
KeyPair?=continuousdemo-eu-west-1
AmiId?=ami-035966e8adab4aaad
RoleArn?=arn:aws:iam::156053543119:role/cloudformation-role

main.template: stacks/*.yml
	aws --profile $(Profile) \
	  cloudformation package \
		--template-file stacks/main.yml \
		--s3-bucket $(InfraBucket) \
		--s3-prefix stacks \
		--output-template-file main.template

deploy: main.template
	aws --profile $(Profile) \
	  cloudformation deploy \
		--template-file main.template \
		--capabilities CAPABILITY_NAMED_IAM \
		--stack-name $(StackName) \
		--role-arn $(RoleArn) \
		--parameter-overrides \
		  BaseDomain=$(BaseDomain) \
		  PrId=$(PrId) \
		  KeyPair=$(KeyPair) \
		  DeployPackagesBucket=$(PackageBucket) \
		  AmiId=$(AmiId)
