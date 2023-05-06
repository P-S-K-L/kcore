#lang racket/base
(require "common.rkt")
(require (for-syntax racket/base)
         syntax/parse/define)

(provide action)

;; action的宏
(define-syntax-rule (action [func param ...])
  (λ (env)
    (func env param ...)))


