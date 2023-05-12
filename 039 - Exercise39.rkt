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

(define CAR                     ; car body with both wheels
  (underlay/align/offset
   "center" "bottom"
   CAR-BODY
   0 WHEEL-RADIUS
   WHEELS))
