(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)
(check-expect (tock 100) 103)
(check-expect (tock 200) 210)
