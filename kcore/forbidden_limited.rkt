#lang typed/racket/base
(require "json_utils.rkt")
(require racket/file)
(require typed/json)

(provide convert
         load-forbidden-limit-config)

;
(: convert (-> (HashTable Symbol JSExpr) (HashTable Integer Integer)))
(define (convert count-id-hash)
  (let ([id-count-pairs : (Listof (Pairof Integer Integer))
                        (foldr (λ ([kv : (Pairof Symbol JSExpr)]
                                   [acc : (Listof (Pairof Integer Integer))])
                                 (append
                                  (map (λ ([id : Integer]) (cons id (symbol->integer (car kv)))) (jsonexp->idlist (cdr kv)))
                                  acc))
                               '()
                               (hash->list count-id-hash))])
    (make-hash id-count-pairs)))

(: load-forbidden-limit-config (-> (U Path String) (HashTable Integer Integer)))
(define (load-forbidden-limit-config path-string)
  (let* ([json-content (file->string path-string)]
         [json-object : (HashTable Symbol JSExpr) (assert (string->jsexpr json-content) hash?)])
    (convert json-object)))
