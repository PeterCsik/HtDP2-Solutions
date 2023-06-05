(define-struct phone [area number])
; A Phone is a structure:
;   (make-phone Number Number)
; interpretation an area code and a local phone number

(define-struct phone# [area switch num])
; A Phone# is a structure:
;  (make-phone Number Number Number)
; interpretation
; -- an area code within the range 001 (included) through 699 (included)
; -- a switch number within the range 001 (included) through 999 (included)
; -- a line number withing the range 001 (included) through 9999 (included)
