#lang racket
(require json)

(define (hello jsexpr)
  (jsexpr->string
   (hash 'hello "Hello, world!"
         'input jsexpr)))
(provide hello)
