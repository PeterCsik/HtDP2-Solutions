; image is represented by image data type
; count of pixels is represented by number data type

; Image -> Number
; counts the number of pixels in a given image
; (define (f img) 0)

; given: image with size 10x10 pixels, expected: 100
; given: image with size 2x5 pixels, expected: 10
; givne: (rectangle 50 30 "solid" "pink")

; (define (image-area img) (... img ...))

(define (image-area img) (* (image-width img) (image-height img)))

(image-area _ ) ; replace "_" with an image
(image-area (rectangle 50 30 "solid" "pink"))
