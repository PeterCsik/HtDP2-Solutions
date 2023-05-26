; ---------- Constant definitions ----------

(define CIRCLE-RADIUS 35)

; ---------- Data definitions ----------

; A N-TrafficLight is one of:
; –- 0 interpretation the traffic light shows red
; –- 1 interpretation the traffic light shows green
; –- 2 interpretation the traffic light shows yellow

; ---------- Function definitions ----------

; N-TrafficLight -> N-TrafficLight
; Yields the next state, given current state cs.
; (define (tl-next-numeric cs) cs)

; given: 0, expected: red
; given: 1, expected: green
; given: 2, expected: yellow

; (define (tl-next-numeric cs)
;    ( ... cs ...))

(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

; N-TrafficLight -> Image
; Renders the current state cs as an image.
;(define (tl-render current-state)
;  (empty-scene 90 30))

; given: red, expected: (circle CIRCLE-RADIUS "solid" "red")
; given: green, expected: (circle CIRCLE-RADIUS "solid" "green")
; given: yellow, expected: (circle CIRCLE-RADIUS "solid" "yellow")

; (define (tl-render cs)                
;     (...cs)

(define (tl-render cs) (circle CIRCLE-RADIUS "solid" (cond
                                                       [ (= cs 0) "red"]
                                                       [ (= cs 1) "green"]
                                                       [ (= cs 2) "yellow"]
                                                       )))

(check-expect (tl-render 0) (circle CIRCLE-RADIUS "solid" "red"))
(check-expect (tl-render 1) (circle CIRCLE-RADIUS "solid" "green"))
(check-expect (tl-render 2) (circle CIRCLE-RADIUS "solid" "yellow"))
 
; ---------- Application ----------

; N-TrafficLight -> N-TrafficLight
; Simulates a clock-based American traffic light.

(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-numeric 1]))
