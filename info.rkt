#lang info
(define collection "aws-lambda-serverless")
(define deps '("base" "yaml"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/aws-lambda-serverless.scrbl" ())))
(define pkg-desc "Racket on aws lambda with serverless framework.")
(define version "2.1")
(define pkg-authors '(tojoqk))
