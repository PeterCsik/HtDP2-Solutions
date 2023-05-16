(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

(reward 18)

; (cond                                           ; paramter is replaced with an argument
;  ((<= 0 18 10) "bronze")
;  ((and (< 10 18) (<= 18 20)) "silver")
;  (else "gold"))
 
; (cond
;  (#false "bronze")                              ; the first condition is evaluated to #false 
;  ((and (< 10 18) (<= 18 20)) "silver")
;  (else "gold"))
 
; (cond
;  ((and (< 10 18) (<= 18 20)) "silver")          ; the first clause is dropped
;  (else "gold"))
 
; (cond
;  ((and #true (<= 18 20)) "silver")              ; the first part of the second condition is evaluated to #true
;  (else "gold"))
 
; (cond
;  ((and #true #true) "silver")                   ; the second part of the second condition is also evaluated to #true
;  (else "gold"))
 
; (cond (#true "silver")                          ; the whole condition is evaluated to #true
; (else "gold"))
 
; "silver"                                        ; the last condition is dropped and the result is presented
