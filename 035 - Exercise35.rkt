;; String -> String
;; Extracts the last character from a non-empty string.

(check-expect (string-last "abc") "c")
(check-expect (string-last "hello") "o")

;(define (string-last str) "a")       ;this is the stub

;(define (string-last str)             ;this is the template
;  (... str))

(define (string-last str)
  (string-ith str (-(string-length str)1)))
