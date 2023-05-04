#lang racket/base
(require racket/list)

(provide (struct-out area)
         draw-area!
         push-to-top!
         push-to-bottom!
         shuffle!
         )

(module+ test
  (require rackunit))

;; 一个区域，内含有序的卡片列表，还有很多标签，例如'me
(struct area (owner cards tags) #:mutable)

;; 从区域最上面获取number张卡
(define (draw-area! area number)
  (let* ([cards (area-cards area)]
         [len (length cards)])
    (if (< len number)
        (error 'draw "not enough card for draw. expected: ~a. got: ~a"  len number)
        (let ([drawed (take cards number)]
              [left (drop cards number)])
          (begin
            (set-area-cards! area left)
            drawed)))))


;; 塞到顶端
(define (push-to-top! area cards)
  (set-area-cards! area (append cards (area-cards area))))

(define (push-to-bottom! area cards)
  (set-area-cards! area (append (area-cards area) cards)))

;; 洗牌
(define (shuffle! area)
  (set-area-cards! area (shuffle (area-cards area))))

(module+ test
  (define test-area (area 'me (list 1 2 3 4 5) '(yard)))
  (define drawed (draw-area! test-area 2))
  (check-equal? drawed (list 1 2))
  (check-equal? (area-cards test-area) (list 3 4 5))
  (push-to-top! test-area (list 6 7))
  (check-equal? (area-cards test-area) (list 6 7 3 4 5))
  (push-to-bottom! test-area (list 233))
  (check-equal? (area-cards test-area) (list 6 7 3 4 5 233)))


