#lang racket/base

(require "game.rkt")
(require "area.rkt")

(define (check-action env who tags)
  ; TODO
  #t)

(define (get-deck env who)
  (if (= who 'me)
    (let ([area (duel-env-areas env)]) (areas-main-deck-0 area))
    (let ([area (duel-env-areas env)]) (areas-main-deck-1 area))))

(define (get-hand env who)
  (if (= who 'me)
    (let ([area (duel-env-areas env)]) (areas-hand-0 area))
    (let ([area (duel-env-areas env)]) (areas-hand-1 area))))

; 备注：所有动作第一个参数都是env
; 卡片里面的效果被解析的时候，生成函数的时候，应该用curry把env绑到第一个参数去
(define (draw env who number)
    ; 所有操作先根据标签是否可以执行，失败和抛异常
    (check-action env who '(draw))
    ; 然后是操作本身
    (let* ([from (get-deck env who)]
          [to (get-hand env who)])
      (define drawed (draw-area from number))
      (begin
        (push-to-top (to drawed))
        (shuffle to))))
