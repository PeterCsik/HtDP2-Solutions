;; A non-empty string is represented by String (data type).
;; interpretation: a non-empty string is a sequence of characters with at least one character

;; (Non-empty) String -> String
;; produces a string like the given one with the last character removed
;; (define (string-remove-last str) "a")

;; given: "abc", expected: "ab"
;; given: "hello world", expected: "hello worl"
;; given: "b", expected: ""

;; (define (string-rest str)
;;   (... str ...))

(define (string-remove-last str)
  (substring str 0 (-(string-length str) 1)))
