#lang racket/base

(module+ test
  (require rackunit))

(require "common.rkt")
(require "card.rkt")
(require "load_card.rkt")
(require "field.rkt")
(require "area.rkt")
(require "env.rkt")

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>
;;
;; For your convenience, we have included LICENSE-MIT and LICENSE-APACHE files.
;; If you would prefer to use a different license, replace those files with the
;; desired license.
;;
;; Some users like to add a `private/` directory, place auxiliary files there,
;; and require them in `main.rkt`.
;;
;; See the current version of the racket style guide here:
;; http://docs.racket-lang.org/style/index.html

;; Code here



(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  (check-equal? (+ 2 2) 4))

(module+ main
  (define argv (current-command-line-arguments))
    ; playground
    (define path (if (> (vector-length argv) 0) (vector-ref argv 0) "./cards/55144522.rktc"))
    (println (format "loading ~a" path))
    (define c (load-card-file path))
    (println c)
    (define env (start-duel))
    ; add two card into my deck
    (define func (effect-action (card-effect c)))
    (func env)
  )
