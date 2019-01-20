#lang scribble/manual
@require[@for-label[aws-lambda-serverless
                    racket/base]]

@title{aws-lambda-serverless}
@author{tojoqk}

@defmodule[aws-lambda-serverless]

Racket on aws lambda with serverless framework.

@section{Requirement}
Install serverless framework.
See @url{"https://serverless.com/"}

@section{Install}
@codeblock{raco pkg install https://github.com/tojoqk/aws-lambda-serverless.git}

@section{Usage}

First, add `#lang aws-lambda-serverless` to your serverless.yml and use @code{arn:aws:lambda:us-east-1:488514468674:layer:bootstrap:2} (@url{https://github.com/tojoqk/aws-lambda-serverless.git}) layer.

Next, build bootstrap file as follows.

@codeblock{
  raco exe --orig-exe -o bootstrap serverless.yml
}

Finally, deploy to aws lambda.
@codeblock{sls deploy}
