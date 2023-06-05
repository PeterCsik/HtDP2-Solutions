(define-struct centry [name home office cell])

(define-struct phone [area number])

(define entry (make-centry "Shriram Fisler"
                           (make-phone 207 "363-2421")
                           (make-phone 101 "776-1099")
                           (make-phone 208 "112-9981")))

(centry-name entry)
; == DrRacket replaces entry
(make-centry
  "Shriram Fisler"
  (make-phone 207 "363-2421")
  (make-phone 101 "776-1099")
  (make-phone 208 "112-9981"))
; == DrRacket uses the law for centry-name
 "Shriram Fisler"


 (phone-area (centry-home entry))
; == DrRacket replaces entry with
(phone-area
 (centry-home
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))
; == DrRacket uses the law for centry-home
(phone-area (make-phone 207 "363-2421"))
; == DrRacket uses the law for phone-area
 207

(phone-number (centry-home entry))
; == DrRacket replaces entry with
(phone-number
 (centry-home
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))
; == DrRacket uses the law for centry-home
 (phone-area (make-phone 207 "363-2421"))
; == DrRacket uses the law for phone-number
 "363-2421"


(phone-area (centry-office entry))
; == DrRacket replaces entry with
(phone-area
 (centry-office
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))
; == DrRacket uses the law for centry-office
 (phone-area (make-phone 101 "776-1099"))
; == DrRacket uses the law for phone-are
 101

(phone-number (centry-office entry))
; == DrRacket replaces entry with
(phone-number
 (centry-office
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))
; == DrRacket uses the law for centry-office
 (phone-number (make-phone 101 "776-1099"))
; == DrRacket uses the law for phone-number
 "776-1099"

 
(phone-area (centry-cell entry))
; == DrRacket replaces entry with
(phone-area
 (centry-cell
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))
; == DrRacket uses the law for centry-cell
 (phone-area (make-phone 208 "112-9981"))
; == DrRacket uses t he law for phone-area
 208

(phone-number (centry-cell entry))
; == DrRacket replaces entry with
(phone-number
 (centry-cell
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))
; == DrRacket uses the law for centry-cell
(phone-number (make-phone 208 "112-9981"))
; == DrRacket uses the law for phone-number
 "112-9981"

; -------------------------------------------------

(phone-area (centry-office entry))
; returns 101
