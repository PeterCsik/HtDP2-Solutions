; A non-empty string is represented by String (data type).
; Interpretation: A non-empty string is a sequence of characters with at least one character.

; Non-empty String -> String
; Extracts the first character from a non-empty string.
; (define (string-first str) "a")

; given: "abc", expected: "a"
; given: "hello world", expected: "h"
; given: "b", expected: "b"

; (define (string-first str)
;   (... str ...))

(define (string-first str)
  (substring str 0 1))

(check-expect (string-first "abc") "a")
(check-expect (string-first "hellow world") "h")
(check-expect (string-first "b") "b")
