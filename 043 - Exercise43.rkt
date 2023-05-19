; ---------- Constant definitions ----------

(define WHEEL-RADIUS 5)    ; the single point of control

(define CAR-BODY
  (above/align "center"
               (rectangle (* WHEEL-RADIUS 3.5) (* WHEEL-RADIUS 1.0) "solid" "red")       ; upper part of the car (windows area)
               (rectangle (* WHEEL-RADIUS 7) (* WHEEL-RADIUS 1.8) "solid" "red")))       ; bottom part of the car (doors area)

(define WHEELS
  (overlay/offset
   (circle WHEEL-RADIUS "solid" "black")    ; the first wheel
   (* WHEEL-RADIUS 3.5) 0                   ; the distance between the wheels
   (circle WHEEL-RADIUS "solid" "black")    ; the second wheel
   ))

(define CAR                     ; car body with both wheels combined
  (underlay/align/offset
   "center" "bottom"
   CAR-BODY
   0 WHEEL-RADIUS
   WHEELS))

(define Y-CAR
  (* WHEEL-RADIUS 5))

(define BACKGROUND
  (empty-scene (* 60 WHEEL-RADIUS) (* 7 WHEEL-RADIUS)))

(define TREE
  (underlay/align/offset
   "center" "bottom"
   (circle (* WHEEL-RADIUS 2) "solid" "green")                        ; crown
   0 (* WHEEL-RADIUS 2)                                               
   (rectangle WHEEL-RADIUS (* WHEEL-RADIUS 3) "solid" "brown")))      ; trunk

(define SCENE
  (overlay/align
   "middle" "bottom"                                         ; the tree is positioned in the center of the background
   TREE
   BACKGROUND
   ))

(define VELOCITY 3)                ; added due to the change of the data definition from WorldState to AnimationState

(define (car-distance as)          ; added due to the change of the data definition from WorldState to AnimationState
  (* as VELOCITY))

; ---------- Data definitions ----------

; An AnimationState is a Number. (as)
; Interpretation: the number of clock ticks since the animation started.

; ---------- Function definitions ----------

; AnimationState -> Image
; Places the car into the SCENE according to the given animation state.
; (define (render as)
;    SCENE))

; given: 0, expected (place-image CAR 0 Y-CAR SCENE)
; given: 50, expected (place-image CAR 150 Y-CAR SCENE)

; (define (render as)
;    (... as ...))

(define (render as)
  (place-image CAR (- (car-distance as) (/ (image-width CAR) 2)) (* Y-CAR (sin (/ as 6))) SCENE))                   

(check-expect (render 0) (place-image CAR (- (car-distance 0) (/ (image-width CAR) 2)) (* Y-CAR (sin (/ 0 6))) SCENE))
(check-expect (render 50) (place-image CAR (- (car-distance 50) (/ (image-width CAR) 2)) (* Y-CAR (sin (/ 50 6))) SCENE))


; AnimationState -> AnimationState
; Adds 1 to the number of clock ticks since the animation started.
; (define (tock as) 0)

; given: 20, expected 21
; given: 100, expected 101

; (define (tock as)
;   (... as ...))

(define (tock as)
  (add1 as))

(check-expect (tock 0) 1) 
(check-expect (tock 100) 101)         

; AnimationState -> Boolean
; Stops the program when the car dissapears on the right side of the scene.
; (define (end? as) #true)

; given: the car position 40 and the scene width 300 , expected #false
; given: the car position 400 and the scene width 300, expected #true

; (define (end? as)
;   (... as ...))

(define (end? as)
  (> (- (car-distance as) (image-width CAR)) (image-width SCENE)))

(check-expect (end? 40) #false)
(check-expect (end? 400) #true)

; ---------- Application ----------

(define (main as)
  (big-bang as
    [to-draw render]
    [on-tick tock]
    [stop-when end?]
  ))
