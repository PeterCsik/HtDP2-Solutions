(define SPEED 3)
(define-struct balld (location direction))
(make-balld 10 "up")


; there is a constant named "SPEED", however, it is note used or referenced

; there is a structure type "balld" that has two fields: "location" and "direction"


; (make-balld 10 "up") creates an instance of the "balld" structure. The value 10 is assigned
; to the "location" field and the string "up" is assigned to the "direction" field

; the instance represents a bouncing ball with an initial location of 10
; and a direction of "up"

; other instances:
(make-balld 10 "down")
(make-balld 86 "down"
(make-balld 39 "up")
(make-balld 759 "up")
(make-balld 240 "left")
(make-balld 7 "right")
