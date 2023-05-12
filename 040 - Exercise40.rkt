(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)           ; returns the expected value: 23
(check-expect (tock 100) 103)         ; returns the expected value: 103
(check-expect (tock 200) 210)         ; test failed, it does not return the expected value: 203
