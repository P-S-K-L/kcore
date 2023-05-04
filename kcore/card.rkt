#lang racket/base
(require racket/contract)
(require (for-syntax racket/base)
         syntax/parse/define)

(provide (struct-out card)
         action)

(provide (contract-out
  (struct effect ([condition (-> any/c any)]
                  [cost (-> any/c any)]
                  [action (-> any/c any)]))))

;; card-type, eg: 'normal-monster 'fast-magic
(struct card (id name type effect) #:transparent)

;; 暂时分成3块
;; condition是返回
(struct effect (condition cost action) #:transparent)

;; action的宏
(define-syntax-rule (action [func param ...])
    (λ (env)
      (func env param ...)))
