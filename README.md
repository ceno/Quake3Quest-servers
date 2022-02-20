# Quake3Quest server infrastructure

This repo contains the template for the cloudformation stack currently providing 6 quake3 servers across two regions:

- eu-west-3 (paris)
- us-east-1 (northern virginia)


## Architecture at a glance

The core idea consists in

- An ElasticIp which provides the static ip for the servers
- An S3 bucket to store the base ioquake3 files, namely all `.pk3` and a pre-compiled arm64 build
- A LaunchTemplate with all the instance configuration. It downloads the data from S3 and uses a mixture of cfn-init metadata and bash to go from a vanilla Amazon Linux 2 ami to a working quake3 server
- An Auto Scaling Group that uses it to instantiate a spot instance


The tree for the S3 bucket looks like

```
s3://my-ioquake3
├── baseq3
│   ├── pak0.pk3
│   ├── pak1.pk3
│   ├── pak2.pk3
│   ├── pak3.pk3
│   ├── pak4.pk3
│   ├── pak5.pk3
│   ├── pak6.pk3
│   ├── pak7.pk3
│   ├── pak8.pk3
│   ├── qagameaarch64.so
├── ioq3ded
└── missionpack
    ├── pak1.pk3
    ├── pak2.pk3
    ├── pak3.pk3
    └── qagameaarch64.so
```
