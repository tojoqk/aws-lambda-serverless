#lang racket
(require (for-syntax syntax/strip-context))
(require "runtime.rkt")

(provide #%app #%top #%top-interaction)
(define-syntax serverless-module-begin
  (syntax-rules ()
    [(_ body ...)
     (#%module-begin
      body ...
      (module+ main
        (define function
          (cond
            [(getenv "_HANDLER")
             => (compose namespace-variable-value string->symbol)]
            [else
             (error "missing _HANDLER environment variable")]))
        (runtime function)))]))
(provide (rename-out [serverless-module-begin #%module-begin]))

(define-syntax HANDLERS
  (syntax-rules ()
    [(_ (handler filename function) ...)
     (begin
       (begin
         (require (rename-in filename [function handler]))
         (namespace-set-variable-value! 'handler handler))
       ...)]))
(provide HANDLERS)
