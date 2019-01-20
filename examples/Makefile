bootstrap:	handler.rkt serverless.yml
	raco exe --orig-exe -o bootstrap serverless.yml

.PHONY: deploy clean

deploy: bootstrap
	sls deploy

clean:
	-rm -f bootstrap
