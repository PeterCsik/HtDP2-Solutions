;; String -> String
;; Produces the give string with the first character removed.

(check-expect (string-rest "abc") "bc")
(check-expect (string-rest "hello") "ello")

;(define (string-rest str) "a")        ;this is the stub

;(define (string-rest str)             ;this the template
;  (... str))

(define (string-rest str)
  (substring str 1))
