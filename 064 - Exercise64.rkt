; posn is two Numbers
; intepretation represents a position in a two-dimensional plane
; the first number is called x-coordinate
; the second number is called y-coordinate

; Distance is a Number
; interpretation represents a path that follows the rectangular grid
; of streets found in Manhattan

; posn -> Distance
; measures the distance of the given posn to the origin
; (define (manhattan-distance p) 0)

(check-expect (manhattan-distance (make-posn 3 4)) 7)
(check-expect (manhattan-distance (make-posn 3 2)) 5)
(check-expect (manhattan-distance (make-posn 2 2)) 4)
(check-expect (manhattan-distance (make-posn 0 2)) 2)

;(define (manhattan-distance p)
;  ( ... (posn-x p) ...
;    ... (posn-y p) ...))

(define (manhattan-distance p)
  (+ (abs (posn-x p))
     (abs (posn-y p))))

; It does not matter which strategy is followed, unless going in the opposite direction.
