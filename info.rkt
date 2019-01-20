#lang info
(define collection "aws-lambda-serverless")
(define deps '("base" "yaml" "aws"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/aws-lambda-serverless.scrbl" ())))
(define pkg-desc "Racket on serverless framework")
(define version "0.0")
(define pkg-authors '(tojoqk))
