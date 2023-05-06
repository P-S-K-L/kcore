#lang typed/racket/base
(require racket/match)
(require racket/string)

(provide (struct-out deck)
         ydk->deck
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
