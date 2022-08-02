all: build

build:
	nvm use
	npm install
	npx aws-cdk synth --app "npx ts-node bin/cdk.ts"  --all

deploy: build
	npx aws-cdk deploy --all
	./scripts/s3sync.sh
	./scripts/refresh.sh

ls:
	./scripts/ls.sh

bootstrap:
	./scripts/bootstrap.sh 1234567 # change this to the actual account id

.PHONY: deploy build ls bootstrap
