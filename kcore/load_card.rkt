#lang racket/base
(require racket/sandbox)

(provide load-card-file)

; decripted
;(define (load-card-file-2 file-path)
;  (define evaluator (parameterize ([sandbox-exit-handler (λ (e) (println "err"))]
;                                   [sandbox-memory-limit 1]
;                                   ;[sandbox-error-output current-error-port]
;                                   ;[sandbox-output current-output-port]
;                                   )
;                      (make-evaluator 'racket/base' '()
;                                      #:requires (list "card.rkt")
;                                      #:allow-for-require '()
;                                      #:allow-read '()
;                                      )))
;  (define result (evaluator (read (open-input-file file-path))))
;  ;(define result (evaluator `(dynamic-require ', file-path 'c)))
;  result
;  )

(require "common.rkt")
(require "card.rkt")
(require "action.rkt")
(define-namespace-anchor a)
(define (load-card-file file-path)
  (define c (read (open-input-file file-path)))
  (define g (make-security-guard (current-security-guard)
                               (λ (who path . perms)
                                 (println (format "file-guard ~a ~a ~a" who path perms))
                                 (cond
                                   ; it works when using: racket -y main.rkt
                                   [(eq? who 'find-system-path) #t]
                                   [(eq? who 'current-directory) #t]
                                   [(eq? who 'file-exists?) #t]
                                   [(eq? who 'resolve-path) #t]
                                   [(eq? who 'directory-exists?) #t]
                                   [else (raise (exn:fail (format "file-guard banned: ~a ~a ~a" who path perms) (current-continuation-marks)))]))
                               (λ (who path . perms)
                                 (raise (exn:fail "network-guard" (current-continuation-marks))))
                               ))
  (parameterize ([current-namespace (namespace-anchor->namespace a)]
                 [current-security-guard g]
                 )
    ;(load file-path)
    (eval c)
    ;(eval '(+ 1 1))
    ))
