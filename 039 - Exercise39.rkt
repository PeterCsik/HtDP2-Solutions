(define WHEEL-RADIUS 3)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle (* WHEEL-RADIUS 3) 0 "outline" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))


(define CAR-PART
  (rectangle (* 4 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))

(define CAR-PART-WITH-WHEEL
  (underlay/xy
   CAR-PART
   WHEEL-RADIUS WHEEL-RADIUS
   WHEEL))

(define CAR-ROOF
  (rectangle (* 4 WHEEL-RADIUS) (* 1 WHEEL-RADIUS) "solid" "red"))

(define CAR
  (above
   CAR-ROOF
   (beside CAR-PART-WITH-WHEEL CAR-PART-WITH-WHEEL)))
