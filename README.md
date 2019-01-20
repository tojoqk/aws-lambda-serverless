# aws-lambda-serverless
[![Build Status](https://travis-ci.com/tojoqk/aws-lambda-serverless.svg?branch=master)](https://travis-ci.com/tojoqk/aws-lambda-serverless)

Racket on aws lambda with serverless framework.

## 1. Requirement

Install serverless framework. See
[https://serverless.com/](https://serverless.com/)

## 2. Install

```
raco pkg install https://github.com/tojoqk/aws-lambda-serverless.git
```

## 3. Usage
Firsft, add `#lang aws-lambda-serverless` to your serverless.yml and
use `arn:aws:lambda:us-east-1:488514468674:layer:bootstrap:2`
\([https://github.com/tojoqk/aws-lambda-bootstrap-runtime.git](https://github.com/tojoqk/aws-lambda-bootstrap-runtime.git)\)
layer.

Next, build bootstrap file as follows.

```
raco exe --orig-exe -o bootstrap serverless.yml
```

Finally, deploy to aws lambda.

```
sls deploy
```

See /examples for details.
