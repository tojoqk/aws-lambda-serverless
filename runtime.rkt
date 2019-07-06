#lang racket/base
(require racket/contract
         racket/match
         racket/function
         racket/string
         json
         net/http-client)

(provide/contract [runtime (-> (-> jsexpr? jsexpr?)
                               void?)])

(define (endpoint&port)
  (match-define (list endpoint port/string)
    (cond
      [(getenv "AWS_LAMBDA_RUNTIME_API") => (curryr string-split ":")]
      [else (error "missing AWS_LAMBDA_RUNTIME_API environment variable")]))
  (values endpoint (string->number port/string)))

(define (headers->alist headers)
  (define (header->pair header)
    (match-define (list _ key value)
      (regexp-match #rx"([^:]*): *(.*)$" header))
    (cons (bytes->string/utf-8 key)
          (bytes->string/utf-8 value)))
  (map header->pair headers))

(define (runtime function)
  (define-values (endpoint port) (endpoint&port))
  (let loop ()
    (define-values (status headers in)
      (http-sendrecv endpoint "/2018-06-01/runtime/invocation/next"
                     #:port port))
    (define event-data (read-json in))
    (when (eof-object? event-data)
      (error "unexpected end of file" event-data))
    (define request-id (cond
                         [(assoc "Lambda-Runtime-Aws-Request-Id"
                                 (headers->alist headers)) => cdr]
                         [else
                          (error "Can't get request id!")]))
    (define error-path (format "/2018-06-01/runtime/invocation/~a/error" request-id))
    (define response-path (format "/2018-06-01/runtime/invocation/~a/response" request-id))
    (with-handlers ([any/c
                     (lambda (e)
                       (http-sendrecv endpoint error-path
                                      #:port port
                                      #:method "POST"
                                      #:data (jsexpr->string
                                              (hash 'errorMessage (format "Uncaught exception ~a" e)
                                                    'errorType "UncaughtException")))
                       (raise e))])
      (define response (function event-data))
      (http-sendrecv endpoint response-path
                     #:port port
                     #:method "POST"
                     #:data (jsexpr->string response)))
    (loop)))
