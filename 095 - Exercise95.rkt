; ---------- Constant definitions ----------

(define SCALE-UNIT 5)

(define UFO (overlay/align "center" "middle"
                           (ellipse (* 7 SCALE-UNIT) (* 1 SCALE-UNIT) "solid" "light gray")
                           (circle (* 1 SCALE-UNIT) "solid" "dark gray")))

(define TANK-WIDTH (* 4 SCALE-UNIT))
(define TANK-HEIGHT (* 1.5 SCALE-UNIT)) 
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "light green"))

(define MISSILE (triangle (* 1 SCALE-UNIT) "solid" "red"))

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

(define-struct tank [loc vel])
; A Tank is a structure:
;  (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn
; interpretation (make-posn x y) is the missile's place

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; A SIGS is one of:
; -- (make-aim UFO Tank)
; -- (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

; Examples (3 instances):

(make-aim (make-posn 20 10) (make-tank 28 -3))

(make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- HEIGHT TANK-HEIGHT)))

(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))

; The three instances are generated according to the first or
; second clause of the data definition because they represent
; different states of word. The first instance represents the
; thank's position during aiming at the UFO. The second one
; shows that a missile was fired. And the last one represents
; how the position of all objects has changed after the fire of
; the missile.
