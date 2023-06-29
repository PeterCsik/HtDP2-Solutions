; ---------- Constant definitions ----------

(define SCALE-UNIT 5)

(define UFO (overlay/align "center" "middle"
                           (ellipse (* 10 SCALE-UNIT) (* 2 SCALE-UNIT) "solid" "light gray")
                           (circle (* 2 SCALE-UNIT) "solid" "dark gray")))

(define TANK (rectangle (* 5 SCALE-UNIT) (* 2 SCALE-UNIT) "solid" "light green"))

(define MISSILE (triangle (* 2 SCALE-UNIT) "solid" "red"))

(define WIDTH (* 50 SCALE-UNIT))    
(define HEIGHT (* 50 SCALE-UNIT))
(define SCENE (empty-scene WIDTH HEIGHT)) ;short for empty scene

(define HILLS (overlay/align/offset "left" "bottom"
                             (triangle (* 40 SCALE-UNIT) "solid" "dark blue")
                             (* -8 SCALE-UNIT) (* -2 SCALE-UNIT)
                             (triangle (* 30 SCALE-UNIT) "solid" "blue")
                              ))

(define BACKGROUND (overlay/align/offset "right" "bottom"
                                  HILLS
                                  0 (* 2 SCALE-UNIT)
                                  SCENE
                                  ))

(define SCENERY (overlay/align "middle" "bottom"
                               MISSILE
                               TANK
                               UFO
                               BACKGROUND))
