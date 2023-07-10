;; A non-empty string is represented by the String data type.
;; interpretation a non-empty string is a sequence of characters with at least one character

;; (Non-empty) String -> String
;; extracts the first character from a non-empty string
;; (define (string-first str) "a")

;; given: "abc", expected: "a"
;; given: "hello world", expected: "h"
;; given: "b", expected: "b"

;; (define (string-first str)
;;   (... str ...))

(define (string-first str)
  (substring str 0 1))

(string-first "abc")            ; returns "a", the expected value
(string-first "hello world")    ; returns "h", the expected value
(string-first "b")              ; returns "b", the expected value
