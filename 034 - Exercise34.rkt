; We use strings to represent non-empty strings
; We use strings to represent single characters

; String -> String
; extracts the first character from a non-empty string
; (define (f s) "c")

; given: "Hello", expected: "H"
; given: "bridge", expected: "b"

; (define (string-first s) (... s ...))

(define (string-first s) (substring s 0 1))

(string-first "Hello")
(string-first "bridge")
