(define RED 0)
(define GREEN 1)
(define YELLOW 2)
 
; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
     
(check-expect (tl-next- ... RED) GREEN)
(check-expect (tl-next- ... YELLOW) RED)
     
     
     
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))
     
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))


; Which of the two is properly designed using the recipe for itemization?
; The second function (tl-next-symbolic cs) is properly designed using the recipe for itematization
; because it fulfills the following criterias:
; 1. the function’s body must be a conditional expression with as many clauses as there are distinct sub-classes in the data definition. 
; If the data definition mentions three distinct sub-classes of input data, it needs contain three cond clauses.
; 2. It must formulate one condition expression per cond clause. Each expression involves the function parameter and identifies 
; one of the sub-classes of data in the data definition.

; Which of the two continues to work if you change the constants to the following

(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

; The second function (tl-next-symbolic cs).
; The function tl-next-symbolic uses symbolic values to represent the traffic light states. 
; As long as the constants RED, GREEN, and YELLOW are updated consistently in the code, changing their numeric values
; does not affect the behavior of the function. Therefore, if the constants are changed as mentioned, the function tl-next-symbolic
; continues to work correctly. The function will switch the state from RED to GREEN, GREEN to YELLOW, and YELLOW back to RED
; based on the updated constants.
; It can be tested:

; ---------- Constant definitions ----------

(define CIRCLE-RADIUS 35)

(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

; ---------- Data definitions ----------

; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

; ---------- Function definitions ----------

; S-TrafficLight -> S-TrafficLight
; Yields the next state, given current state cs.
; (define (tl-next-symbolic cs) cs)

(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic YELLOW) RED)
(check-expect (tl-next-symbolic GREEN) YELLOW)
     
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; S-TrafficLight -> Image
; Renders the current state cs as an image.
;(define (tl-render current-state)
;  (empty-scene 90 30))

(define (tl-render cs) (circle CIRCLE-RADIUS "solid"
                               (cond
                                 [(equal? cs RED) "red"]
                                 [(equal? cs GREEN) "green"]
                                 [(equal? cs YELLOW) "yellow"]
                                         )))

(check-expect (tl-render RED) (circle CIRCLE-RADIUS "solid" "red"))
(check-expect (tl-render GREEN) (circle CIRCLE-RADIUS "solid" "green"))
(check-expect (tl-render YELLOW) (circle CIRCLE-RADIUS "solid" "yellow"))
 
; ---------- Application ----------

; S-TrafficLight -> S-TrafficLight
; Simulates a clock-based American traffic light.

(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-symbolic 1]))
