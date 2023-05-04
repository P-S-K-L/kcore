#lang racket/base
(require "area.rkt")
(require "field.rkt")
(provide (struct-out env)
         (struct-out areas)
         start-duel
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

(struct env (areas) #:mutable)

(define (empty-env)
  (env (areas (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (area 'me (list) (list 'me))
                   (new-field))))


; 开始决斗，新建env
(define (start-duel)
  (empty-env))
