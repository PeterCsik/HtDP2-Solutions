; A non-empty string is represented by String (data type).
; Interpretation: a non-empty string is a sequence of characters with at least one character.

; (Non-empty) String -> String
; Produces a string with the first character removed.
; (define (string-first str) "a")

; given: "abc", expected: "bc"
; given: "hello world", expected: "ello world"
; given: "b", expected: ""

; (define (string-first str)
;   (... str ...))

(define (string-first str)
  (substring str 1 (string-length str)))

(check-expect (string-first "abc") "bc")
(check-expect (string-first "hello world") "ello world")
(check-expect (string-first "b") "")
