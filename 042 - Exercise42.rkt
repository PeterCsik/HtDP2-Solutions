(define WHEEL-RADIUS 5)

(define WIDTH-OF-WORLD (* 40 WHEEL-RADIUS))

(define HEIGHT-OF-WORLD (* 5 WHEEL-RADIUS))

(define CROWN-OF-TREE  (circle (* 1.5 WHEEL-RADIUS) "solid" "green"))

(define TRUNK-OF-TREE  (rectangle (* 0.25 WHEEL-RADIUS) (* 2.5 WHEEL-RADIUS) "solid" "brown"))

(define TREE (underlay/align/offset "middle" "top"
              CROWN-OF-TREE
              0 (* 2 WHEEL-RADIUS)
              TRUNK-OF-TREE))

(define BACKGROUND (overlay/offset
                    TREE
                   (* 8 WHEEL-RADIUS) 0
                   (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle (* WHEEL-RADIUS 3) 0 "outline" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR-ROOF
  (rectangle (* 4 WHEEL-RADIUS) (* 1 WHEEL-RADIUS) "solid" "red"))

(define CAR-PART
  (rectangle (* 4 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))

(define CAR-PART-WITH-WHEEL
  (underlay/xy
   CAR-PART
    WHEEL-RADIUS WHEEL-RADIUS
   WHEEL))

(define CAR
  (above
   CAR-ROOF
   (beside
    CAR-PART-WITH-WHEEL
    CAR-PART-WITH-WHEEL)))

(define Y-CAR (+(- (image-height BACKGROUND) (image-height CAR)) (/ (image-height CAR) 2)))

(define VELOCITY 3)

(define (car-distance as)
  (* as VELOCITY))

; AnimationState: (as)
; the number of clock ticks since the animation started

; AnimationState -> Image
; place the image of the car x pixels from the left margin of the BACKGROUND image based on the AnimationState
; (define (render as) BACKGROUND)

(define (render as)
  (place-image CAR (- (car-distance as)(/ (image-width CAR) 2)) (+ Y-CAR  (* (sin as) 5)) BACKGROUND))

(check-expect (render 30) (place-image CAR 70 (+ Y-CAR (* (sin 30) 5)) BACKGROUND))
(check-expect (render 50) (place-image CAR 130 (+ Y-CAR (* (sin 50) 5)) BACKGROUND))

; AnimationState -> AnimationState
; adds 1 to the number of clock ticks since the animation started
; (define (tock as) (... as ...))

(define (tock as)
  (add1 as))

(check-expect (tock 20) 21)
(check-expect (tock 100) 101)

; AnimationState -> Boolean
; after each event, big-bang evaluates (end? as)
; (define (end? as) (... as ...))

(define (end? as)
  (> (car-distance as)(+ (image-width BACKGROUND) (image-width CAR))))

; AnimationState -> AnimationState
; launches the program from some initial state
; (define (main as) (... as ...))

(define (main as)
  (big-bang as
    [to-draw render]
    [on-tick tock]
    [stop-when end?]))
