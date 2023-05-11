; A non-empty string is represented by String (data type).
; Interpretation: a non-empty string is a sequence of characters with at least one character.

; (Non-empty) String -> String
; Extracts the last character from a non-empty string.
; (define (string-last str) "a")

; given: "abc", expected: "c"
; given: "hello world", expected: "d"
; given: "b", expected: "b"

; (define (string-last str)
;   (... str ...))

(define (string-last str)
  (string-ith str (-(string-length str)1)))

(check-expect (string-last "abc") "c")
(check-expect (string-last "hello world") "d")
(check-expect (string-last "b") "b")
