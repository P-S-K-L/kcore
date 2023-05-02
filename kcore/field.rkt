#lang racket/base

(require racket/match)
(require "card.rkt")

(provide new-field)

; NOTE: 先用直觉的方式设计，所以格子也记录各种信息


;; 一个格子
;; rule-enable? ex区这排只有2个格子能用，其他的在规则上不存在
;; game-enable? 正常的格子有时候会被关闭
;; 一个格子只能装1个张卡
(struct slot (rule-enable? game-enable? owner x y card) #:transparent)

;; 场上的部分
(struct field (v) #:transparent)

(define (rule-enable? x y)
  (match (list x y)
    [(list 0 2) #f]
    [(list 2 2) #f]
    [(list 4 2) #f]
    [_ #t]
    ))

(define (default-owner x y)
  (cond
    [(< y 2) 'opponent]
    [(> y 2) 'me]
    [(= y 2) 'unknown]
    ))

(define (new-field)
  (define v (build-vector 5 (lambda (y)
                              (build-vector 5 (lambda (x)
                                                (slot
                                                  (rule-enable? x y)
                                                  #t
                                                  (default-owner x y)
                                                  x
                                                  y
                                                  null))))))
  (field v))
