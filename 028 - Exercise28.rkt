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
     
(profit 1)          ; returns 511.2
(profit 2)          ; returns 937.2
(profit 3)          ; returns 1063.2
(profit 4)          ; returns 889.2
(profit 5)          ; returns 415.2


(profit 2.8)          ; returns 1062
(profit 2.9)          ; returns 1064.1 This is the best ticket price to a dime: 2.9.
(profit 3.0)          ; returns 1063.2
(profit 3.1)          ; returns 1059.3
(profit 3.2)          ; returns 1052.4
