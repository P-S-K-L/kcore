#lang typed/racket/base

(require racket/match)
(require "common.rkt")

(provide new-field)

; NOTE: 先用直觉的方式设计，所以格子也记录各种信息

(define (slot-exist? x y)
  (match (list x y)
    [(list 0 2) #f]
    [(list 2 2) #f]
    [(list 4 2) #f]
    [_ #t]
    ))

(: default-owner (-> Integer Integer Owner))
(define (default-owner x y)
  (cond
    [(< y 2) 'opponent]
    [(> y 2) 'me]
    [else 'none]
    ))

(: new-field (-> field))
(define (new-field)
  (define v
    (build-vector
     5
     (λ ([y : Integer])
       (build-vector
        5 (λ ([x : Integer])
            (if (slot-exist? x y)
                (slot #t (default-owner x y) x y null)
                null))))))
  (field v))
