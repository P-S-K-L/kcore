#lang typed/racket/base

(provide (struct-out card)
         (struct-out effect)
         (struct-out area)
         (struct-out areas)
         (struct-out env)
         (struct-out slot)
         (struct-out field)
         (struct-out card-state)
         (struct-out card-instance)
         Condition
         Action
         Cost
         Person
         Owner
         CardType)

(define-type Condition (-> env Any))
(define-type Action (-> env Any))
(define-type Cost (-> env Any))
(define-type Person (U 'me 'opponent))
(define-type Owner (U Person 'none))
(define-type CardType (U 'monster 'magic 'trap))
(define-type Face (U 'up 'down))

(struct card ([id : Integer] [name : String] [type : CardType] [effect : effect]) #:transparent)

; TODO more field
(struct card-state ([face : Face]))

;; 卡片实例
(struct card-instance ([id : Integer] [state : card-state]))

;; 暂时分成3块
;; condition是返回
(struct effect ([condition : Condition] [cost : Cost] [action : Action]) #:transparent)

;; 一个区域，内含有序的卡片列表，还有很多标签，例如'me
(struct area ([owner : Owner] [cards : (Listof card)] [tags : (Listof Symbol)]) #:mutable)

;; 一个格子
;; rule-enable? ex区这排只有2个格子能用，其他的在规则上不存在
;; game-enable? 正常的格子有时候会被关闭
;; 一个格子只能装1个张卡
(struct slot ([enable? : Boolean]
              [owner : Owner]
              [x : Integer]
              [y : Integer]
              [card : (U card Null)]) #:transparent)

;; 场上的部分
(struct field ([v : (Vectorof (Vectorof (U Null slot)))]) #:transparent)


;; 整个游戏的所有区域
(struct areas ([hand-0 : area]
               [main-deck-0 : area]
               [extra-deck-0 : area]
               [graveyard-0 : area]
               [banished-0 : area]
               [hand-1 : area]
               [main-deck-1 : area]
               [extra-deck-1 : area]
               [graveyard-1 : area]
               [banished-1 : area]
               ;; 属于两人一起的场上
               [field : field]
               ))


(struct env ([areas : areas]) #:mutable)
