(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)           ; actual value 23 agrees with 23, the expected value
(check-expect (tock 100) 103)         ; actual value 103 agrees with 103, the expected value
(check-expect (tock 200) 210)         ; a check failure: Actual value 203 differs from 210, the expected value
