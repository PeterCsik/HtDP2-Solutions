(- 200 (cond [(> 100 200) 0] [else y]))

; (- 200 (cond [(> 100 200) 0] [else 100]))               ; (- 200 (cond (#false 0) (else 100)))
                                                          ; (- 200 (cond (else 100)))
                                                          ; (- 200 100)
                                                          ; 100

; (- 200 (cond [(> 210 200) 0] [else 210]))               ; (- 200 (cond (#true 0) (else 210)))
                                                          ; (- 200 0)
                                                          ; 200
                                                          

(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define ROCKET ...)                                                 ; replace "..." with a picture of a racket
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
 
(define (create-rocket-scene.v5 h)
  (place-image ROCKET 50
  (cond 
    [(<= h ROCKET-CENTER-TO-TOP) h]
    [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
  MTSCN))
