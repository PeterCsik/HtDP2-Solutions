(define WHEEL-RADIUS 15)

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

; WorldState: data that represents the state of the world (ws)
; A WorldState is a Number
; interpretation the number of pixels between the left border of the sceen and the car

; WorldState -> Image
; place the image of the car x pixels from the left margin of the BACKGROUND image
; (define (render ws) BACKGROUND)

(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 90) (place-image CAR 90 Y-CAR BACKGROUND))

; WorldState -> WorldState
; adds 3 to x to move the car right
; (define (tock ws) (... ws ...))

(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)
(check-expect (tock 100) 103)

; WorldState -> Boolean
; after each event, big-bang evaluates (end? ws)
; (define (end? ws) (... ws ...))

(define (end? ws)
  (> ws(+ (image-width BACKGROUND) (image-width CAR))))

; WorldState -> WorldState
; launches the program from some initial state
; (define (main ws) (... ws ...))

(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tock]
    [stop-when end?]))
