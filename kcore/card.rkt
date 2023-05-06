#lang typed/racket/base
(require "common.rkt")
(require/typed "load_card.rkt"
               [load-card-file (-> String card)])
(require racket/path)
(require racket/string)

(provide default-face
         default-card-state
         load-global-cards
         get-card-hash
         )


(define (default-face) 'down)

(define (default-card-state)
  (card-state (default-face)))

;; 把目录所有卡片数据加载进card-hash
(: load-cards (-> String (HashTable Integer card)))
(define (load-cards dir)
  (define card-hash : (HashTable Integer card) (make-hash))
  (for ([file (directory-list dir)]
        #:when (equal? (filename-extension file) #"rktc")
        )
    (define id : Integer (let ([name (file-name-from-path file)])
                 (cond [(equal? #f name) (error "fuck")]
                       [else (assert (string->number (car (string-split (path->string name) "."))) exact-integer?)])))
    (define card (load-card-file (string-append dir (path->string file))))
    (hash-set! card-hash id card))
  card-hash)

;; 全局。所有卡片id到卡片脚本的存储。
(define card-hash : (HashTable Integer card) (make-hash))

(: get-card-hash (-> (HashTable Integer card)))
(define (get-card-hash)
  card-hash)

(: load-global-cards (-> String Void))
(define (load-global-cards dir)
  (set! card-hash (load-cards dir)))
