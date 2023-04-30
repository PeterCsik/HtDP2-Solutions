(define CIRCLE-RADIUS 35)


;; A TrafficLight is  one of the following Strings:
;; -- "red"
;; -- "green"
;; -- "yellow"
;; interpretation the three strings represent the three
;; possible states that a traffic light may assume


;; TrafficLight -> Image
;; renders and image of the TrafficeLight based on the the current state
;; (definition (traffic-circle cs) img)           ; this is the stub

(check-expect (traffic-circle "red") (circle CIRCLE-RADIUS "solid" "red"))

; (definition (traffic-circle cs)                ; this is the template
;     (...cs)

(define (traffic-circle cs) (circle CIRCLE-RADIUS "solid" cs))


;; TrafficLight -> TrafficLight
;; yields the next state give current states cs
; (definition (traffic-light-next cs) "a")       ; this is the stub

(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

; (definition (traffic-light-next cs)            ; this is the template
;      (...cs))

(define (traffic-light-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))


;; TrafficLight -> TrafficLight
;; changes the states of the traffic light

(define (TheTrafficLight cs)
  (big-bang "yellow"
            [on-tick traffic-light-next 2.5]
            [to-draw traffic-circle]))
