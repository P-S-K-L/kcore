#lang typed/racket/base
(require racket/match)
(require racket/string)
(require typed/json)
(require "json_utils.rkt")

(provide (struct-out deck)
         ydk->deck
         json->deck
         )

;; 代表玩家的卡组
;; 先支持ydk

(struct deck ([author : String]
             [main : (Listof Integer)]
             [extra : (Listof Integer)]
             [side : (Listof Integer)])
             #:transparent)

(: ydk->deck-helper (-> (Listof String) String String (Listof Integer) (Listof Integer) (Listof Integer) deck))
(define (ydk->deck-helper lines seg author main extra side)
  (match lines
    ['() (deck author (reverse main) (reverse extra) (reverse side))]
    [(cons line rest)
     (match line
       ["#main" (ydk->deck-helper rest "#main" author main extra side)]
       ["!side" (ydk->deck-helper rest "!side" author main extra side)]
       ["#extra" (ydk->deck-helper rest "#extra" author main extra side)]
       [(regexp #px"\\d+")
        (let ([num (assert (string->number line) exact-integer?)])
            (match seg
                ["#main" (ydk->deck-helper rest seg author (cons num main) extra side)]
                ["#extra" (ydk->deck-helper rest seg author main (cons num extra) side)]
                ["!side" (ydk->deck-helper rest seg author main extra (cons num side))]
                [_ (error "invalid segment word in ydk: " seg)]))]
       [(? string?)
        (match (string-prefix? line "#created by")
          [#t (ydk->deck-helper rest seg (substring line 13) main extra side)]
          [_ (error "Invalid line: " line)])]
       [_ (error "Invalid line: " line)])]))

(: ydk->deck (-> String deck))
(define (ydk->deck ydk-content)
    (ydk->deck-helper (string-split ydk-content "\n") "" "" '() '() '())
)

(: json->deck (-> String deck))
(define (json->deck json-content)
  (let* ([json-object : (HashTable Symbol JSExpr) (assert (string->jsexpr json-content) hash?)]
         [author : String (assert (hash-ref json-object 'author) string?)]
         [main : (Listof Integer) (jsonexp->idlist (hash-ref json-object 'main))]
         [side : (Listof Integer) (jsonexp->idlist (hash-ref json-object 'side))]
         [extra : (Listof Integer) (jsonexp->idlist (hash-ref json-object 'extra))])
    (deck author main extra side)))
