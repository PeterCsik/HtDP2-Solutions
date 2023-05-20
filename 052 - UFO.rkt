; ---------- Constant definitions ----------

(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define UFO (overlay/align "center" "middle" (ellipse 40 5 "solid" "light gray") (circle 5 "solid" "dark gray")))

; ---------- Data definitions ----------

; A WorldState is a Number. (y)
; Interpretation: it is number of pixels between the top and the UFO and falls into one of three intervals:
; -- between 0 and CLOSE
; -- between CLOSE and HEIGHT
; -- below HEIGHT

; ---------- Function definitions ----------

; WorldState -> Image
; Places UFO at given height into the center of scene.
; (define (render y) img)

; given: 11, expected: (place-image UFO ... 11 scene)

; (define (render y)
;   (place-image UFO ... y scene))

(define (render y)
  (place-image UFO (/ WIDTH 2) y MTSCN))

(check-expect (render 10)(place-image UFO (/ WIDTH 2) 10 MTSCN))

; WorldState -> WorldState
; Computes next location of UFO.
; (define (nxt y) 0)

; given: 0, expected: 3

; (define (nxt y)
;   ( ... y ...))

(define (nxt y)
  (+ y 3))

(check-expect (nxt 0) 3)

; WorldState -> Image
; Adds a status line to the scene created by render.
; (define render/status y) img)

; given: (0,CLOSE], expected: orange line with "descending" text
; given: (CLOSE, HEIGHT], expected: green line with "closing in" text
; given: > HEIGHT, expected: red line with "landed" text

; (define render/status y)
;  (... y ...))

(define (render/status y)
  (place-image
    (cond
      [(<= 0 y CLOSE) (text "descending" 11 "green")]
      [(and (< CLOSE y) (< y (- HEIGHT (image-height UFO))))(text "closing in" 11 "orange")]
      [(>= y (- HEIGHT (image-height UFO)))(text "landed" 11 "red")])
    20 20
    (render y)))

(check-expect (render/status 42)
              (place-image (text "closing in" 11 "orange")
                           20 20
                           (render 42)))

; WorldState -> Boolean
; Stops the program when the UFO hits the bottom of the scene.
; (define (end? y) #true)

; given: 50, expected: #false
; given: 100, expected: #true

; (define (end? y)
;   (... y ...))

(define (end? y)
  (> y (- HEIGHT (image-height UFO))))

(check-expect (end? 50) #false)
(check-expect (end? 100) #true)

; ---------- Application ----------

(define (main y0)
  (big-bang y0
    [on-tick nxt]
    [to-draw render/status]
    [stop-when end?]
    ))
  