(define-struct movie [title producer year])
; A Movie is a structure:
;    (make-movie String String Number)
; interpretation a title of a movie, its producer and year of release

(define-struct person [name hair eyes phone])
; A Person is a structure:
;   (make-person String String String String)
; interpretation a person's name, hair color, eyes color, and phone number

(define-struct pet [name number])
; A Pet is a structure:
;   (make-pet String Number)
; interpretation a pet's name and its identification number

(define-struct CD [artist title price])
; A CD is a structure:
;   (make-CD String String Number)
; interpretation an artist or a band name, the CD title and the CD price

(define-struct sweater [material size producer])
; A Sweater is a structure:
;   (make-swater String String String)
; interpretation sweater's material, size of the sweater, and producer name
