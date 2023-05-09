#lang typed/racket/base
(require typed/json)

(provide jsonexp->idlist
         symbol->integer
         )

(: jsonexp->idlist (-> JSExpr (Listof Integer)))
(define (jsonexp->idlist exp)
    (cond
      [(list? exp) (map (λ (x) (assert x exact-integer?)) exp)]
       [else (error "not list")]))


(: symbol->integer (-> Symbol Integer))
(define (symbol->integer s)
  (assert (string->number (symbol->string s)) exact-integer?))
