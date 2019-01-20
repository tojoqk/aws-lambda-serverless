# aws-lambda-serverless

tojoqk

```racket
 (require aws-lambda-serverless)                                                                                   
                                 package:                                                                          
                                [aws-lambda-serverless](https://pkgs.racket-lang.org/package/aws-lambda-serverless)
```

Racket on aws lambda with serverless framework.

## 1. Requirement

Install serverless framework. See
[https://serverless.com/](https://serverless.com/)

## 2. Install

```racket
raco pkg install https://github.com/tojoqk/aws-lambda-serverless.git
```

## 3. Usage

First, add ‘\#lang aws-lambda-serverless‘ to your serverless.yml and use
`arn:aws:lambda:us-east-1:488514468674:layer:bootstrap:2`
\([https://github.com/tojoqk/aws-lambda-bootstrap-runtime.git](https://github.com/tojoqk/aws-lambda-bootstrap-runtime.git)\)
layer.

Next, build bootstrap file as follows.

```racket
raco exe --orig-exe -o bootstrap serverless.yml
```

Finally, deploy to aws lambda.

```racket
sls deploy
```

See /examples for details.
