(define-struct point-in-time [hour minute second])
; A Point-in-time is a structure:
;   (make-point-in-time Number Number Number)
; interpretation represents point in time in hours, minutes and seconds

(define ex1 (make-point-in-time 12 30 2))
(define ex2 (make-point-in-time 0 0 2))
(define ex3 (make-point-in-time 23 59 59))

; point-in-time -> Number
; produces the number of seconds that have passed since midnight
; (define (time->seconds p) 0))

(check-expect (time->seconds ex1) 45002)
(check-expect (time->seconds ex2) 2)
(check-expect (time->seconds ex3) 86399)

;(define (time->seconds p)
;  (... (point-in-time-hour p) ... (point-in-time-minute p)
;       ... (point-in-time-second p)))

(define (time->seconds p)
  (+ (* (point-in-time-hour p) 60 60)
     (* (point-in-time-minute p) 60)
     (point-in-time-second p)))
