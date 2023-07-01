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
(define SCENE (empty-scene WIDTH HEIGHT)) ;short for empty scene

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
