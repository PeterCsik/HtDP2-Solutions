(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))
 
(string-insert "helloworld" 6)         ; expected value "hellow_orld"

; (string-append
; (substring "helloworld" 0 6)
; "_"
; (substring "helloworld" 6))

; (string-append "hellow" "_" (substring "helloworld" 6))

; (string-append (substring s 0 i) "_" (substring s i)))
; (string-append "hellow" "_" "orld")

; "hellow_orld"                        ; returns the expected value