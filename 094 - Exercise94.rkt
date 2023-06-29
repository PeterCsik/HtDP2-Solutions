; ---------- Constant definitions ----------

(define UFO (overlay/align "center" "middle" (ellipse 40 5 "solid" "light gray") (circle 5 "solid" "dark gray")))
(define TANK (rectangle 25 10 "solid" "light green"))

(define WIDTH 250)    
(define HEIGHT 150)
(define SCENE (empty-scene WIDTH HEIGHT)) ;short for empty scene
(define HILLS (overlay/align/offset "left" "bottom"
                             (triangle 140 "solid" "dark blue")
                             -40 -10
                             (triangle 120 "solid" "blue")
                              ))

(define BACKGROUND (overlay/align/offset "right" "bottom"
                                  HILLS
                                  0 10
                                  SCENE
                                  ))

(define SCENERY (overlay/align "middle" "bottom"
                 UFO
                 TANK
                 BACKGROUND))
