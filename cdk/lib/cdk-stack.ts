import { Size, Stack, StackProps } from 'aws-cdk-lib';
import * as cfninc from 'aws-cdk-lib/cloudformation-include';
import { Construct } from 'constructs';
import * as cdk from 'aws-cdk-lib'
import * as ec2 from 'aws-cdk-lib/aws-ec2'
import * as s3 from 'aws-cdk-lib/aws-s3'
import * as s3deploy from 'aws-cdk-lib/aws-s3-deployment'

interface CdkStackProps extends cdk.StackProps {
  readonly server0Name?: string;
  readonly server1Name?: string;
  readonly rconPassword?: string;
  readonly prowlApiToken?: string;
  readonly webhookParam?: string;

}

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props?: CdkStackProps) {
    super(scope, id, props);

    const defaultVpc = ec2.Vpc.fromLookup(this, "DefaultVPC",{ isDefault: true })
    
    const subnets = [defaultVpc.publicSubnets[0].subnetId]

    const template = new cfninc.CfnInclude(this, 'Template', { 
      templateFile: '../template.yml',
      preserveLogicalIds: true,
      parameters: {
        'VpcId': defaultVpc.vpcId,
        'Subnets': subnets,
        'KeyName': 'aws_international',
        'BucketName': this.stackName.toLowerCase(),
        'Server0Name': props?.server0Name ?? '',
        'Server1Name': props?.server1Name ?? '',
        'RconPassword': props?.rconPassword ?? this.node.tryGetContext('RCON_PASSWORD'),
        'ProwlApiToken': props?.prowlApiToken ?? this.node.tryGetContext('PROWL_API_TOKEN'),
        'WebhookUrl': this.node.tryGetContext(props?.webhookParam ?? 'WEBHOOK_URL_TEST'),
      },
    });

  // This is making each deployment take very long and cost a bunch of money
  // even though it's supposed to only do a sync, and the files are all there already
  //
  //   const cfnBucket = template.getResource('S3Bucket') as s3.CfnBucket;
  //   const bucket = s3.Bucket.fromBucketName(this, 'Bucket', cfnBucket.ref);

  //   // Note: the total size of the q3 package, including custom maps, is about 750MB
  //   // The default lambda ephemeral storage of 512mb is not enough
  //   new s3deploy.BucketDeployment(this, 'DeployFiles', {
  //     sources: [s3deploy.Source.asset('../dist')], // 'folder' contains your empty files at the right locations
  //     destinationBucket: bucket,
  //     memoryLimit: 1024, // default is 128
  //     ephemeralStorageSize: Size.gibibytes(4),
  //     exclude: ['.DS_Store'],
  // });

  }
}
