(define (distance-to-0 ap)
  (sqrt
   (+ (sqr (posn-x ap))
      (sqr (posn-y ap)))))
 
 
(distance-to-0 (make-posn 3 4))             ; result: 5
(sqrt
  (+  (sqr (posn-x (make-posn 3 4))
      (sqr (posn-y (make-posn 3 4)))))

(sqrt
  (+  (sqr 3)
      (sqr (posn-y (make-posn 3 4)))))
      
(sqrt
  (+ 9
      (sqr 4)))
      
(sqrt (+ 9 16))
(sqrt 25)
5

(distance-to-0 (make-posn 6 (+ 2 4)))       ; result: #i8.48528137423857
 
(+ (distance-to-0 (make-posn 12 5)) 10)     ; #i8.48528137423857
