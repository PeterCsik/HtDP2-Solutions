; We use strings to represent from non-empty strings
; We use strings to represent single characters

; String -> String
; extracts the last character from a non-empty string
; (define (g str) "m")

; given: "monitor", expected "r"
; given: "old", expected: "d"

; (define (string-last str) ( ... str ...))

(define (string-last str)(string-ith str (-(string-length str)1)))

(string-last "monitor")
(string-last "old")
