; we use string data type to represent strings (textual information)

; String -> String
; removes the first character from a string
; define (f str) "bcd")

; given: "Mozart", expected: "ozart"
; given: "city", expected: "ity"
; given: "a", expected ""

; (define (string-rest str) (... str ...))

(define (string-rest str)(substring str 1))

(string-rest "Mozart")
(string-rest "bridge")
(string-rest "a")
