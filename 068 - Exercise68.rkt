(define-struct ball (location velocity))
(define-struct vel (deltax deltay))

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

(define-struct ballf (x y deltax deltay))

; an instance of ballf that has the same interpretation as ball1
(make-ballf 30 40 -10 5)
