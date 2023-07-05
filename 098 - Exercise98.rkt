; ---------- Constant definitions ----------

(define SCALE-UNIT 5)

(define UFO (overlay/align "center" "middle"
                           (ellipse (* 7 SCALE-UNIT) (* 1 SCALE-UNIT) "solid" "light gray")
                           (circle (* 1 SCALE-UNIT) "solid" "dark gray")))

(define TANK-WIDTH (* 4 SCALE-UNIT))
(define TANK-HEIGHT (* 1.5 SCALE-UNIT)) 
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "light green"))

(define MISSILE (triangle (* 2 SCALE-UNIT) "solid" "red"))

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

(define ex2-aim (make-aim (make-posn 20 190)
                          (make-tank 100 -3)))

(define ex1-fired (make-fired (make-posn 20 10)
                              (make-tank 20 -3)
                              (make-posn 20 (- HEIGHT (* TANK-HEIGHT 2)))))

(define ex2-fired (make-fired (make-posn 20 100)
                              (make-tank 20 3)
                              (make-posn 20 120)))

(define ex3-fired (make-fired (make-posn 20 100)
                              (make-tank 20 3)
                              (make-posn 28 100)))

(define ex4-fired (make-fired (make-posn 20 100)
                              (make-tank 150 3)
                              (make-posn 150 90)))

(define ex5-fired (make-fired (make-posn 20 190)
                              (make-tank 150 3)
                              (make-posn 150 90)))

(define ex6-fired (make-fired (make-posn 20 190)
                              (make-tank 150 -3)
                              (make-posn 150 (- HEIGHT (* TANK-HEIGHT 2)))))


; ---------- Function definitions ----------

;;  ---------- Function definition (si-render) ----------
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

;;; ---------- Auxiliary functions for si-render function ----------

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

;;  ---------- Function definition (si-game-over?) ----------

; SIGS -> Boolean
; Stops the game if
; -- the UFO lands or
; -- if the missle hits the UFO.
; (define (si-game-over? s) #true)

(check-expect (si-game-over? ex1-aim) #false)
(check-expect (si-game-over? ex2-aim) #true)
(check-expect (si-game-over? ex1-fired) #false)
(check-expect (si-game-over? ex2-fired) #false)
(check-expect (si-game-over? ex3-fired) #true)
(check-expect (si-game-over? ex4-fired) #false)
(check-expect (si-game-over? ex5-fired) #true)
(check-expect (si-game-over? ex6-fired) #true)

(define (si-game-over? s)
  (cond
    [(aim? s) (ufo-landed? s)]
    [(fired? s)
     (cond
        [(ufo-landed? s) #true]
        [(ufo-hit? s) #true]
        [else #false])]
    ))

;;; ---------- Auxiliary functions for si-game-over? function ----------

; SIGS -> Boolean
; checks if the UFO landed
; (define (ufo-landed? s) #true)

(check-expect (ufo-landed? ex1-aim) #false)
(check-expect (ufo-landed? ex2-aim) #true)
(check-expect (ufo-landed? ex1-fired) #false)
(check-expect (ufo-landed? ex2-fired) #false)
(check-expect (ufo-landed? ex3-fired) #false)
(check-expect (ufo-landed? ex4-fired) #false)
(check-expect (ufo-landed? ex5-fired) #true)
(check-expect (ufo-landed? ex6-fired) #true)

;(define (ufo-landed? s)
;  (cond
;    [(aim? s) (... (aim-ufo s) ...)]
;    [(fired? s) (... (fired-ufo s) ...)]))

(define (ufo-landed? s)
  (cond
    [(aim? s)(if (>= (posn-y (aim-ufo s)) (- HEIGHT (image-height UFO))) #true #false)]
    [(fired? s) (if (>= (posn-y (fired-ufo s)) (- HEIGHT (image-height UFO))) #true #false)]
    ))


; SIGS -> Boolean
; checks if the UFO was hit by a missile
; (define (ufo-hit? s) #true)

(check-expect (ufo-hit? ex1-aim) #false)
(check-expect (ufo-hit? ex2-aim) #false)
(check-expect (ufo-hit? ex1-fired) #false)
(check-expect (ufo-hit? ex2-fired) #false)
(check-expect (ufo-hit? ex3-fired) #true)
(check-expect (ufo-hit? ex4-fired) #false)
(check-expect (ufo-hit? ex5-fired) #false)
(check-expect (ufo-hit? ex6-fired) #false)

;(define (ufo-hit? s)
;  (if (fired? s)
;      (... (fired-ufo s) ... (fired-missile s) ...)))

(define (ufo-hit? s)
  (if (and (fired? s) (and (< (posn-y (fired-missile s)) (+ (posn-y (fired-ufo s))(/ (image-height UFO) 2)))
                              (and (> (posn-x (fired-missile s)) (- (posn-x (fired-ufo s))(/ (image-width UFO) 2)))
                                   (< (posn-x (fired-missile s)) (+ (posn-x (fired-ufo s))(/ (image-width UFO) 2)))))) #true #false))

;;  ---------- Function definition (si-render-final) ----------

; SIGS -> Image
; shows the final state of the game
; (define (si-render-final s) img)

(define (si-render-final s)
  (cond
    [(ufo-landed? s)
     (overlay
     (text "GAME OVER\nUFO LANDED" (* 5 SCALE-UNIT) "red")
     (si-render s))]
    
    [(ufo-hit? s)
     (overlay
      (text "YOU WON!" (* 5 SCALE-UNIT) "gold")
      (si-render s))]
    ))
