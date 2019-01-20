#lang racket
(require syntax/strip-context)
(require yaml)

(module+ test
  (require rackunit))

(provide (rename-out [serverless-read read]
                     [serverless-read-syntax read-syntax]))


(define (serverless-read in)
  (syntax->datum (serverless-read-syntax #f in)))

(define (serverless-read-syntax src in)
  (let ([yaml (read-yaml in)])
    (strip-context
     #`(module aws-lambda-serverless-mod "expander.rkt"
         (HANDLERS
          #,@(datum->syntax
              #f
              (remove-duplicates
               (for/list ([(name function) (hash-ref yaml "functions")])
                 (define handler (hash-ref function "handler"))
                 (match-define (list filename function-name)
                   (string-split handler "."))
                 (list (string->symbol handler)
                       (string-append filename ".rkt")
                       (string->symbol function-name))))))))))

(module+ test
  (check-equal? (serverless-read (open-input-string #<<END
service: test

provider:
  name: aws
  runtime: provided
  memorySize: 128
  timeout: 1

functions:
  hello:
    handler: handler.hello
    layers:
      - arn:aws:lambda:us-east-1:488514468674:layer:bootstrapTest:2
  world:
    handler: handler.world
    layers:
      - arn:aws:lambda:us-east-1:488514468674:layer:bootstrapTest:2
END
                                                    ))
                `(module aws-lambda-serverless-mod "expander.rkt"
                   (HANDLERS (handler.hello "handler.rkt" hello)
                             (handler.world "handler.rkt" world)))))
