;; A non-empty string is represented by String (data type).
; interpretation: a non-empty string is a sequence of characters with at least one character

;; (Non-empty) String -> String
;; produces a string like the given one with the first character removed
;; (define (string-rest str) "a")

;; given: "abc", expected: "bc"
;; given: "hello world", expected: "ello world"
;; given: "b", expected: ""

;; (define (string-rest str)
;;   (... str ...))

(define (string-rest str)
  (substring str 1 (string-length str)))

(string-rest "abc")            ; returns "bc", the expected value
(string-rest "hello world")    ; returns "ello world", the expected value
(string-rest "b")              ; returns "", the expected value
