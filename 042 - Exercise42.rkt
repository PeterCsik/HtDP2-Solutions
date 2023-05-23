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

; ---------- Data definitions ----------

; A WorldState is a Number. (cw)
; Interpretation: the number of pixels between the left border of the scene the x-coordinate of the right-most edge of the car.

; ---------- Function definitions ----------

; WorldState -> Image
; Places the car into the SCENE according to the given world state.
; (define (render cw) img)

; given: 0, expected (place-image CAR 0 Y-CAR SCENE)
; given: 50, expected (place-image CAR 50 Y-CAR SCENE)

; (define (render cw)
;    (... cw ...))

(define (render cw)
  (place-image CAR (- cw (/ (image-width CAR) 2)) Y-CAR SCENE))                   ; <<< before:(place-image CAR cw Y-CAR SCENE))

(check-expect (render 0) (place-image CAR (- 0 (/ (image-width CAR) 2)) Y-CAR SCENE))
(check-expect (render 50) (place-image CAR (- 50 (/ (image-width CAR) 2)) Y-CAR SCENE))


; WorldState -> WorldState
; Moves the car by 3 pixels for every clock tick.
; (define (tock cw) 0)

; given: 20, expected 23
; given: 100, expected 103

; (define (tock cw)
;   (... cw ...))

(define (tock cw)
  (+ cw 3))

(check-expect (tock 20) 23)
(check-expect (tock 100) 103)

; WorldState -> Boolean
; Stops the program when the car dissapears on the right side of the scene.
; (define (end? cw) #true)

; given: the car position 40 and the scene width 300 , expected #false
; given: the car position 400 and the scene width 300, expected #true

; (define (end? cw)
;   (... cw ...))

(define (end? cw)
  (> (- cw (image-width CAR)) (image-width SCENE)))       ; <<< before: (> (- cw (/(image-width CAR) 2)) (image-width SCENE)))

(check-expect (end? 40) #false)
(check-expect (end? 400) #true)

; ---------- Application ----------

(define (main cw)
  (big-bang cw
    [to-draw render]
    [on-tick tock]
    [stop-when end?]
  ))
