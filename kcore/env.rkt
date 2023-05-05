#lang typed/racket/base
(require "common.rkt")
(require "field.rkt")
(provide (struct-out env)
         (struct-out areas)
         start-duel
         )


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
