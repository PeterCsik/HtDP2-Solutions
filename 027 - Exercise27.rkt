(define BASE-ATTENDANCE 120)
(define BASE-TICKET-PRICE 5.0)
(define ATTENDANCE-CHANGE 15)
(define TICKET-PRICE-CHANGE 0.1)
(define FIXED-COST 180)
(define VARIABLE-COST 0.04)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-TICKET-PRICE) (/ ATTENDANCE-CHANGE TICKET-PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
