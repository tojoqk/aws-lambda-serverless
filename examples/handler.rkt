#lang racket
(require json)

(define (hello jsexpr)
  (hash 'hello "Hello, world!"
        'input jsexpr))
(provide hello)
