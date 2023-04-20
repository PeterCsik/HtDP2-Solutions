;; String -> String
;; Produces the given string with the last character removed.

(check-expect (string-remove-last "abc") "ab")
(check-expect (string-remove-last "hello") "hell")

;(define (string-remove-last str) "a")      ;this is the stub

;(define (string-remove-last str)           ;this is the template
;  (... str))

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
