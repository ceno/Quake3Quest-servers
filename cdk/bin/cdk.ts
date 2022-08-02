#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { CdkStack } from '../lib/cdk-stack';

const app = new cdk.App();

//NOTE: the stack name Quake3Quest-etc will be used as the bucket name as well.
new CdkStack(app, 'Quake3Quest-GameServer-California', {
  /* For more information, see https://docs.aws.amazon.com/cdk/latest/guide/environments.html */
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'us-west-1' },
  server0Name: '',
  server1Name: 'US DEMO',
  webhookParam: 'WEBHOOK_URL_US'
});


new CdkStack(app, 'Quake3Quest-GameServer-Sydney', {
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'ap-southeast-2' },
  server0Name: '',
  server1Name: 'SYDNEY DEMO'
});

/* Other regions, now offline
new CdkStack(app, 'Quake3Quest-GameServer-Virginia', {
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'us-east-1' },
  server0Name: 'VIRGINIA FULL GAME',
  server1Name: 'VIRGINIA DEMO'
});

new CdkStack(app, 'Quake3Quest-GameServer-Tokyo', {
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'ap-northeast-1' },
  server0Name: 'TOKYO FULL GAME',
  server1Name: 'TOKYO DEMO'
});

new CdkStack(app, 'Quake3Quest-GameServer-Montreal', {
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'ca-central-1' },
  server0Name: 'MONTREAL FULL GAME',
  server1Name: 'MONTREAL DEMO'
});

new CdkStack(app, 'Quake3Quest-GameServer-Seoul', {
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'ap-northeast-2' },
  server0Name: 'SEOUL 1',
  server1Name: 'SEOUL 2',
  rconPassword: 'habanera-nonstop-SPIRT',
  prowlApiToken:'ac7f020a6221ddf2533038e2f42481bdd1654a32'
});

new CdkStack(app, 'Quake3Quest-GameServer-Saopaulo', {
  env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'sa-east-1' },
  server0Name: 'SAO PAULO 1',
  server1Name: 'SAO PAULO 2',
  rconPassword: 'habanera-nonstop-SPIRT',
  prowlApiToken:'ac7f020a6221ddf2533038e2f42481bdd1654a32'
});
*/