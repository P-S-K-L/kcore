#lang racket/base
(provide (struct-out duel-env)
         (struct-out areas)
         ;start-duel
         )

(struct areas (hand-0
               main-deck-0
               extra-deck-0
               graveyard-0
               banished-0
               hand-1
               main-deck-1
               extra-deck-1
               graveyard-1
               banished-1
               ;; 属于两人一起的场上
               field
               ))

(struct duel-env (areas))

; TODO
;(define (empty-env)
;    (duel-env (areas (

; 开始决斗，新建env
;(define (start-duel)
;  (duel-env))
