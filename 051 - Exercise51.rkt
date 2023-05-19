; ---------- Constant definitions ----------

(define CIRCLE-RADIUS 35)

; ---------- Data definitions ----------

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; Interpretation: the three strings represent the three possible states that a traffic light may assume.

; ---------- Function definitions ----------

; TrafficLight -> Image
; Renders an image of the TrafficLight based on the the current state.
; (define (traffic-circle cs) img)

; given: red, expected: (circle CIRCLE-RADIUS "solid" "red")
; given: green, expected: (circle CIRCLE-RADIUS "solid" "green")
; given: yellow, expected: (circle CIRCLE-RADIUS "solid" "yellow")

; (define (traffic-circle cs)                
;     (...cs)

(define (traffic-circle cs) (circle CIRCLE-RADIUS "solid" cs))

(check-expect (traffic-circle "red") (circle CIRCLE-RADIUS "solid" "red"))
(check-expect (traffic-circle "green") (circle CIRCLE-RADIUS "solid" "green"))
(check-expect (traffic-circle "yellow") (circle CIRCLE-RADIUS "solid" "yellow"))

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

(define (TheTrafficLight cs)
  (big-bang "yellow"
            [on-tick traffic-light-next 2.5]
            [to-draw traffic-circle]))
