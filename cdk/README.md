# CDK

This CDK project is used to deploy the template in the root level across
multiple regions and provides tooling to facilitate managing them.

Basically evolved out of a basic project produced by `cdk init`


## Requirements

### Dependencies

This project only requires `node v16.14.2` to be installed. Recommend using `nvm` to manage version.
All the cdk and typescript stuff is installed in runtime, as every cdk call is wrapped with `npx`

### Config

This project requires a `cdk.json` in the root of the `cdk` directory. This
basically holds secrets which will then be passed as parameters to
`template.yml` (hence why it's "gitignored"). Contents should be as follows

```json
{
  "app": "npx ts-node --prefer-ts-exts bin/cdk.ts",
  "watch": {
    "include": [
      "**"
    ],
    "exclude": [
      "README.md",
      "cdk*.json",
      "**/*.d.ts",
      "**/*.js",
      "tsconfig.json",
      "package*.json",
      "yarn.lock",
      "node_modules",
      "test"
    ]
  },
  "context": {
    "@aws-cdk/aws-apigateway:usagePlanKeyOrderInsensitiveId": true,
    "@aws-cdk/core:stackRelativeExports": true,
    "@aws-cdk/aws-rds:lowercaseDbIdentifier": true,
    "@aws-cdk/aws-lambda:recognizeVersionProps": true,
    "@aws-cdk/aws-cloudfront:defaultSecurityPolicyTLSv1.2_2021": true,
    "@aws-cdk-containers/ecs-service-extensions:enableDefaultLogDriver": true,
    "@aws-cdk/aws-ec2:uniqueImdsv2TemplateName": true,
    "@aws-cdk/core:checkSecretUsage": true,
    "@aws-cdk/aws-iam:minimizePolicies": true,
    "@aws-cdk/core:target-partitions": [
      "aws",
      "aws-cn"
    ],
    "RCON_PASSWORD": "CHANGEME",
    "PROWL_API_TOKEN": "CHANGEME",
    "WEBHOOK_URL_TEST": "CHANGEME",
    "WEBHOOK_URL_EU": "CHANGEME",
    "WEBHOOK_URL_US": "CHANGEME"
  }
}
```

This project also expects aws authentication to be set up and working as
default. A basic way to do it is with static credentials in
`~/.aws/credentials`

```
[default]
aws_access_key_id=xxxxxxxxxxxxx
aws_secret_access_key=xxxxxxxxxxxxxxxxxxx
```

## Deploying a new region

Add new region to `./scripts/bootstrap.sh` and edit the `bootstrap` target in the Makefile. Then

```
make bootstrap
make deploy
```

## Retiring a region
* Empty the corresponding S3 bucket first
* Manually delete the stack
* Delete the intialisation code in `cdk.ts`

## Reference commands from project template

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `cdk deploy`      deploy this stack to your default AWS account/region
* `cdk diff`        compare deployed stack with current state
* `cdk synth`       emits the synthesized CloudFormation template
