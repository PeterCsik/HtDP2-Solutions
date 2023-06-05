; ---------- Constant definitions ----------

(define ESSENTIAL-ITEMS-LOWER-BOUNDARY 0)
(define STANDARD-ITEMS-LOWER-BOUNDARY 1000)
(define LUXURY-ITEMS-LOWER-BOUNDARY 10000)

(define ESSENTIAL-ITEMS-RATE 0.00)
(define STANDARD-ITEMS-RATE 0.05)
(define LUXURY-ITEMS-RATE 0.08)

; ---------- Data definitions ----------

; A Price falls into one of three intervals: 
; -- 0 through 1000 (excluded)
; -- 1000 (included) through 10000 (excluced)
; -- 10000 (included) and above.
; Interpretation: the price of an item.

; ---------- Function definitions ----------

; Price -> Number
; Computes the amount of tax charged for p.
; (define (sales-tax p) 0)

; given: 100,    expected: 0
; given: 999,    expected: 0
; given: 1000,   expected: 50
; givne: 9999,   expected: 499.95
; given: 10000,  expected: 800
; given: 99999,  expected: 7999.92

; (define (sales-tax p)
;   (cond
;     [(and (<= 0 p) (< p 1000)) ...]
;     [(and (<= 1000 p) (< p 10000)) ...]
;     [(>= p 10000) ...]))

(define (sales-tax p)
  (cond
    [(and (<= ESSENTIAL-ITEMS-LOWER-BOUNDARY p) (< p STANDARD-ITEMS-LOWER-BOUNDARY)) ESSENTIAL-ITEMS-RATE]
    [(and (<= STANDARD-ITEMS-LOWER-BOUNDARY p) (< p LUXURY-ITEMS-LOWER-BOUNDARY)) (* STANDARD-ITEMS-RATE p)]
    [(>= p LUXURY-ITEMS-LOWER-BOUNDARY) (* LUXURY-ITEMS-RATE p)]))

(check-expect (sales-tax 100) (* 0.00 100))
(check-expect (sales-tax 999) (* 0.00 999))
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 9999) (* 0.05 1000))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 99999) (* 0.08 99999))
 
; ---------- Application ----------

(sales-tax p)
