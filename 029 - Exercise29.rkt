(define BASE-ATTENDANCE 120)
(define BASE-TICKET-PRICE 5.0)
(define ATTENDANCE-CHANGE 15)
(define TICKET-PRICE-CHANGE 0.1)
(define FIXED-COST 0.00)
(define VARIABLE-COST 1.50)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-TICKET-PRICE) (/ ATTENDANCE-CHANGE TICKET-PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))


(profit 3)        ; returns 630, before 1063.2
(profit 4)        ; returns 675, before 889.2
(profit 5)        ; returns 420, before 415.2
