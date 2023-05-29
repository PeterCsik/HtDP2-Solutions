(define-struct movie [title producer year])

; constructor: make-movie
; selectors: movie-title, movie-producer, movie-year
; predicate: movie?


(define-struct person [name hair eyes phone])

; constructor: make-person
; selectors: person-name, person-hair, person-eyes, person-phone
; predicate: person?


(define-struct pet [name number])

; constructor: make-pet
; selectors: pet-name, pet-number
; predicate: pet?


(define-struct CD [artist title price])

; constructor: make-CD
; selectors: CD-artist, CD-title, CD-price
; predicate: CD?


(define-struct sweater [material size producer])

; constructor: make-sweater
; selectors: sweater-material, sweater-size, sweater-producer
; predicate: sweater?
