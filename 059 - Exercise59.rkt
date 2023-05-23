; ---------- Constant definitions ----------

(define CIRCLE-RADIUS 35)

; ---------- Data definitions ----------

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; Interpretation: the three strings represent the three possible states that a traffic light may assume.

; ---------- Function definitions ----------

; TrafficLight -> TrafficLight
; Yields the next state, given current state cs.
; (define (tl-next cs) cs)

; given: red, expected: green
; given: green, expected: yellow
; given: yellow, expected: red

; (define (tl-next s)
;    ( ... s ...))

(define (tl-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")

; TrafficLight -> Image
; Renders the current state cs as an image.
;(define (tl-render current-state)
;  (empty-scene 90 30))

; given: red, expected: (circle CIRCLE-RADIUS "solid" "red")
; given: green, expected: (circle CIRCLE-RADIUS "solid" "green")
; given: yellow, expected: (circle CIRCLE-RADIUS "solid" "yellow")

; (define (tl-render cs)                
;     (...cs)

(define (tl-render cs) (circle CIRCLE-RADIUS "solid" cs))

(check-expect (tl-render "red") (circle CIRCLE-RADIUS "solid" "red"))
(check-expect (tl-render "green") (circle CIRCLE-RADIUS "solid" "green"))
(check-expect (tl-render "yellow") (circle CIRCLE-RADIUS "solid" "yellow"))
 
; ---------- Application ----------

; TrafficLight -> TrafficLight
; Simulates a clock-based American traffic light.

(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))
