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
s3://my-ioquake3-bucket
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
├── ioq3ded.arm64
└── missionpack
    ├── pak1.pk3
    ├── pak2.pk3
    ├── pak3.pk3
    └── qagameaarch64.so
```

For binaries, look at these forks for builds for amazon linux 2
- https://github.com/ceno/ioq3/releases/tag/v1.36
- https://github.com/ceno/dpmaster/releases/tag/v2.2

# Budget

For a base `t4g.nano` server, the expected cost base is as follows

| AWS Service | Configuration | Daily  | Monthly | Yearly |
|-------------|---------------|--------|---------|--------|
| EC2         | t4g.nano spot | $0.03  | $0.90   | $11    |
| EBS Volume  | 2GB gp3       | $0.005 | $0.16   | $1.92  |
| Elastic IP  | -             | $0     | $0      | $0     |
| Network Out | 2GB/month max | $0.005 | $0.16   | $1.92  |
| S3          | 500GB         | -      | $0.012  | $0.14  |
| TOTAL       | -             | $0.04  | $1.23   | ~$15   |

Upgrading to a `t4g.micro` doubles the EC2 cost but everything else
stays the same.


## Notes


#### CPU Utilisation observed during play tests

| Num Players | CPU    |
|-------------|--------|
| 0           | 2-3%   |
| 8           | 12-15% |

| Num Bots    | CPU    |
|-------------|--------|
| 0           | 2-3%   |
| 8           | 5-6% |


#### CPU budget

| Type      | Total CPU Baseline |
| --------- | ------------------ |
| t4g.nano  | 10%                |
| t4g.micro | 20%                |
| t4g.small | 40%                |

#### Reference  Spot instance prices

```
Ireland
nano:
t4g.nano	$0.0014 per Hour
t3a.nano	$0.0015 per Hour
t3.nano		$0.0017 per Hour
micro
t4g.micro	$0.0028 per Hour
t3.micro	$0.0034 per Hour
t3a.micro	$0.0032 per Hour
t2.micro	$0.0038 per Hour

Paris
t4g.nano	$0.0014 per Hour
t3.nano		$0.0018 per Hour
t3a.nano	$0.0019 per Hour
t4g.micro	$0.0028 per Hour
t3a.micro	$0.0032 per Hour
t3.micro	$0.0035 per Hour
t2.micro	$0.0040 per Hour
```

# Custom maps

```
# Custom1 and custom2 
wget https://ws.q3df.org/maps/downloads/hub3aeroq3.pk3
wget https://ws.q3df.org/maps/downloads/hub3tourney1.pk3
wget https://ws.q3df.org/maps/downloads/map_cpm1a.pk3
wget https://ws.q3df.org/maps/downloads/ZTN3DM1.pk3
wget https://ws.q3df.org/maps/downloads/alkdm06.pk3
wget https://ws.q3df.org/maps/downloads/Bal3dm3.pk3
wget https://ws.q3df.org/maps/downloads/simetrik.pk3
wget https://ws.q3df.org/maps/downloads/klzdeadly.pk3
wget https://ws.q3df.org/maps/downloads/charon3dm8.pk3
wget https://ws.q3df.org/maps/downloads/kamq3dm2.pk3
wget https://ws.q3df.org/maps/downloads/auh3dm1.pk3
wget https://ws.q3df.org/maps/downloads/mksteel.pk3
wget https://ws.q3df.org/maps/downloads/akutatourney6.pk3
wget https://ws.q3df.org/maps/downloads/akutadm1.pk3
wget https://ws.q3df.org/maps/downloads/akutadm2.pk3
wget https://ws.q3df.org/maps/downloads/akutadm3.pk3
wget https://ws.q3df.org/maps/downloads/map-charonq2dm1v2.pk3
wget https://ws.q3df.org/maps/downloads/tabd2map01.pk3
# Requires manual unzipping:
wget https://lvlworld.fast-stable-secure.net/a-f/akutatourney8.zip

# custom3 - The cream off the top
# See https://lvlworld.com/review/id:664
wget https://ws.q3df.org/maps/downloads/map-natedm2.pk3
wget https://ws.q3df.org/maps/downloads/ik3dm1.pk3
wget https://ws.q3df.org/maps/downloads/japanc.pk3
wget https://ws.q3df.org/maps/downloads/mrcq3t3.pk3
wget https://ws.q3df.org/maps/downloads/ztn3dm2.pk3
wget https://ws.q3df.org/maps/downloads/lun3dm2.pk3
wget https://ws.q3df.org/maps/downloads/Bal3dm2.pk3
wget https://ws.q3df.org/maps/downloads/ZTN3DM1.pk3
wget https://ws.q3df.org/maps/downloads/auh3dm2.pk3
wget https://ws.q3df.org/maps/downloads/shortcircuit.pk3
wget https://ws.q3df.org/maps/downloads/map_cpm8.pk3
wget https://ws.q3df.org/maps/downloads/auh3dm1.pk3
wget https://ws.q3df.org/maps/downloads/fff.pk3
wget https://ws.q3df.org/maps/downloads/devdm3.pk3
wget https://ws.q3df.org/maps/downloads/d3xf1.pk3
wget https://ws.q3df.org/maps/downloads/tig_den.pk3

# custom4 - The Top Peg
# See https://lvlworld.com/download/id:929 
wget https://ws.q3df.org/maps/downloads/yog3dm2.pk3
wget https://ws.q3df.org/maps/downloads/Bal3dm3.pk3
wget https://ws.q3df.org/maps/downloads/alkdm06.pk3
wget https://ws.q3df.org/maps/downloads/map_cpm1a.pk3
wget https://ws.q3df.org/maps/downloads/map_cpm11.pk3
wget https://ws.q3df.org/maps/downloads/qxtourney1.pk3
wget https://ws.q3df.org/maps/downloads/saiko_tourney1a.pk3
wget https://ws.q3df.org/maps/downloads/hub3dm1.pk3
wget https://ws.q3df.org/maps/downloads/hub3aeroq3.pk3
wget https://ws.q3df.org/maps/downloads/Bal3dm4.pk3
# custom5 - 20 Years
# See https://lvlworld.com/review/id:2401
wget https://ws.q3df.org/maps/downloads/chiropteraDM.pk3
wget https://ws.q3df.org/maps/downloads/auh3dm1.pk3
wget https://ws.q3df.org/maps/downloads/d3xf1.pk3
wget https://ws.q3df.org/maps/downloads/ik3dm2.pk3
wget https://ws.q3df.org/maps/downloads/fr3dm1.pk3
wget https://ws.q3df.org/maps/downloads/jof3dm2.pk3
wget https://ws.q3df.org/maps/downloads/focal_p132.pk3
wget https://ws.q3df.org/maps/downloads/hub3dm1.pk3
wget https://ws.q3df.org/maps/downloads/hub3aeroq3a.pk3
```

# Admin tips and tricks
### SSH
Because every machine uses the same static IP. ssh keeps. Disable strict host key checking

~/.ssh/config

```
Host *
    StrictHostKeyChecking no
```

chmod 400 ~/.ssh/config

### Disk space
List folder in current directory
```
du -h -s *
```
List files in current directory
```
```

du -h -s * | sort -h
/usr/lib/locale

date && df -h && du -h -s /* | sort -h
