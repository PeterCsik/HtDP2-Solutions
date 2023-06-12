(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
; interpretation represents a 3-dimensional point 

(define ex1 (make-r3 0 3 4))
(define ex2 (make-r3 0 0 6))

; R3 -> Number
; computes the distance of p to the origin
; (define (r3-distance-to-0 p)
;   (... (r3-x p) ... (r3-y p) ... (r3-z p) ...))

(check-expect (r3-distance-to-0 ex1) 5)
(check-expect (r3-distance-to-0 ex2) 6)

(define (r3-distance-to-0 p)
  (sqrt (+ (sqr (r3-x p))
           (sqr (r3-y p))
           (sqr (r3-z p)))))
