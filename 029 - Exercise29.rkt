(define fixed-cost 0)
(define variable-cost 1.5)
(define base-attendance 120)
(define base-ticket-price 5.0)
(define ticket-price-change 0.1)
(define attendance-change 15)

(define (attendees ticket-price)
  (- base-attendance (* (- ticket-price base-ticket-price) (/ attendance-change ticket-price-change))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixed-cost (* variable-cost (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; Application:

> (profit 3) ;; before 1063.2
630
> (profit 4) ;; before 889.2
675
> (profit 5) ;; before 415.2
420
