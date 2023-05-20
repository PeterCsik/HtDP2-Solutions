; (place-image ROCKET 10 (- ... CENTER) BACKG) can be replaced with the following auxiliary function

(define (center-rocket x)                                      ; an auxiliary function
  (place-image ROCKET (/ WIDTH 2) (- HEIGHT x CENTER) BACKG))
