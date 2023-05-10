(define (==> x y)
  (or (not x) y))

(==> #false #false)       ; returns #true
; (or (not #false) #false)
; (or #true #false)
; #true
