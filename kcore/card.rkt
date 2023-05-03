#lang racket/base
(require (for-syntax racket/base)
         syntax/parse/define)

(provide (struct-out card) (struct-out effect)
         effect-macro
         )

;; card-type, eg: 'normal-monster 'fast-magic
(struct card (id name type effect) #:transparent)

;; 暂时分成3块
;; condition是返回
(struct effect (condition cost action) #:transparent)

; 这个宏简单地把效果宏后面的2个元素变成字符串
(define-syntax-parser effect-macro
  [(effect-macro [action count])
   #'(effect (format "2: ~a ~a" action count))]
  [(effect-macro [action])
   #'(effect (format "1: ~a" action))])
