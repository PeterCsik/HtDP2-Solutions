; we use string to represent strings (textual information)
; we use string to represent single characters

; String -> String
; removes the last character from a string
; (define (f s) "a")

; given: "New York", expected: "New Yor"
; given: "bus", expected "bu"
; given: "x", expected ""

; (define (string-remove-last s) ( ... s ... )

(define (string-remove-last s) (substring s 0 (- (string-length s) 1)))

(string-remove-last "New York")
(string-remove-last "bus")
(string-remove-last "a")
