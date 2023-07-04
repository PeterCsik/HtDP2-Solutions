; ---------- Constant definitions ----------

(define SCALE-UNIT 5)

(define UFO (overlay/align "center" "middle"
                           (ellipse (* 7 SCALE-UNIT) (* 1 SCALE-UNIT) "solid" "light gray")
                           (circle (* 1 SCALE-UNIT) "solid" "dark gray")))

(define TANK-WIDTH (* 4 SCALE-UNIT))
(define TANK-HEIGHT (* 1.5 SCALE-UNIT)) 
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "light green"))

(define MISSILE (triangle (* 4 SCALE-UNIT) "solid" "red"))

(define WIDTH (* 40 SCALE-UNIT))    
(define HEIGHT (* 40 SCALE-UNIT))
(define SCENE (empty-scene WIDTH HEIGHT))

(define HILLS (overlay/align/offset "left" "bottom"
                             (triangle (* 30 SCALE-UNIT) "solid" "dark blue")
                             (* -8 SCALE-UNIT) (* -2 SCALE-UNIT)
                             (triangle (* 20 SCALE-UNIT) "solid" "blue")
                              ))

(define BACKGROUND (overlay/align/offset "right" "bottom"
                                  HILLS
                                  0 (* 2 SCALE-UNIT)
                                  SCENE
                                  ))

; ---------- Data definitions ----------

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define ex1-ufo (make-posn 40 50))
(define ex2-ufo (make-posn 100 180))

(define-struct tank [loc vel])
; A Tank is a structure:
;  (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define ex1-tank (make-tank 100 3))
(define ex2-tank (make-tank 100 -3))


; A Missile is a Posn
; interpretation (make-posn x y) is the missile's place

(define ex1-missile (make-posn 30 150))
(define ex2-missile (make-posn 100 100))


(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; A SIGS is one of:
; -- (make-aim UFO Tank)
; -- (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

(define ex1-aim (make-aim (make-posn 20 10)
                          (make-tank 28 -3)))

(define ex1-fired (make-fired (make-posn 20 10)
                              (make-tank 80 -3)
                              (make-posn 80 (- HEIGHT (* TANK-HEIGHT 2)))))

(define ex2-fired (make-fired (make-posn 20 100)
                              (make-tank 100 3)
                              (make-posn 22 103)))

(define ex3-fired (make-fired (make-posn 20 10)
                              (make-tank 28 3)
                              (make-posn 28 -5)))

(define ex4-fired (make-fired (make-posn 28 190)
                              (make-tank 28 3)
                              (make-posn 28 190)))

; The three instances above are generated according to the first or
; second clause of the data definition because they represent
; different states of word. The first instance represents the
; thank's position during aiming at the UFO. The second one
; shows that a missile was fired. And the last one represents
; how the position of all objects has changed after the fire of
; the missile.


; ---------- Function definitions ----------

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to the SCENERY
; (define (si-render s) BACKGROUND)


;(define (si-render s)
;  (cond
;    [(aim? s) (... (aim-tank s) ... (aim-ufo s) ...)]
;    [(fired? s) (... (fired-tank s) ... (fired-ufo s)
;                     ...(fired-missile s) ...)]))

(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BACKGROUND)))]))

;; ---------- Auxiliary functions for si-render function ----------

; UFO Image -> Image
; adds u to the given image img
; (define (ufo-render u img) img)

(check-expect (ufo-render (make-posn 100 30) BACKGROUND)
              (place-image UFO 100 30 BACKGROUND))

; (define (ufo-render u img)
;  (... (posn-x u) ... (posn-y u)
;       ... img ...))

(define (ufo-render u img)
              (place-image UFO (posn-x u) (posn-y u) img))


; Tank Image -> Image
; adds t to the given image img
; (define (tank-render t img) img)

(check-expect (tank-render (make-tank 100 3) BACKGROUND)
              (place-image TANK 100 (- 200 7.5) BACKGROUND))

; (define (tank-render t img)
;  (... (tank-loc t) ... img ...))

(define (tank-render t img)
              (place-image TANK (tank-loc t) ( - HEIGHT TANK-HEIGHT) img))


; Missile Image -> Image
; add m to the give image img
; (define (missile-render m img) img)

(check-expect (missile-render (make-posn 20 30) BACKGROUND)
              (place-image MISSILE 20 30 BACKGROUND))

; (define (missile-render m img)
;  (... (posn-x m) ... (posn-y m)
;       ... img ...))

(define (missile-render m img)
              (place-image MISSILE (posn-x m) (posn-y m) img))


; These two functions:

"(tank-render
  (fired-tank ex4-fired)
  (ufo-render (fired-ufo ex4-fired)
              (missile-render (fired-missile ex4-fired)
                              BACKGROUND)))"
 
"(ufo-render
  (fired-ufo ex4-fired)
  (tank-render (fired-tank ex4-fired)
               (missile-render (fired-missile ex4-fired)
                               BACKGROUND)))"

; will produce the same result, unless UFO and TANK overlaps.
; They both use the same concept: one auxiliary function produces a background image
; for another auxiliary function.

; The first function: (missile-render) produces a background image for (ufo-render) and then
; (ufo-render) produces a background image for (tank-render).
; - 1. (missile-render) produces an image with a missile.
; - 2. (ufo-render) uses the image produced by (missile-render) and ads the ufo picture to it.
; - 3. then finally, (tank-render) uses the image with the missile and the ufo, and ads a tank to it.

; The second function: (missile-render) produces a background image for (tank-render) and then
; (tank-render) produces a background image for (ufo-render).
; - 1. (missile-render) produces an image with a missile.
; - 2. (tank-render) uses the the image produced by (missile-render) and ads a tank picture to it.
; - 3. then finally, (ufo-render) uses the image with the missile and the tank, and ads an ufo to it.

; That explains why the functions produce a difference result in case the ufo and the tank picture
; overlaps.
