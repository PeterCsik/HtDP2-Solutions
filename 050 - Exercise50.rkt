; ---------- Function definition ----------

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; Interpretation: the three strings represent the three possible states that a traffic light may assume.

; TrafficLight -> TrafficLight
; Yields the next state given current state s.
; (define (traffic-light-next str) "a")

; given: red, expected: green
; given: green, expected: yellow
; given: yellow, expected: red

; (define (traffic-light-next s)
;    ( ... s ...))

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

; ---------- Application ----------

(traffic-light-next "red")
(traffic-light-next "green")
(traffic-light-next "yellow")
