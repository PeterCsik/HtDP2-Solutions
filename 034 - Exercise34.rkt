;; String -> String
;; Extracts the first character from a non-empty string

(check-expect (string-first "abc") "a")
(check-expect (string-first "hello")"h")

;(define (string-first str) "a")        ;this is the stub

;(define (string-first str)             ;this is the template 
;  (...str))

(define (string-first str)
  (substring str 0 1))
