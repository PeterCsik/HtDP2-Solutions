;; An image area is a (positive non-zero) Number.
;; interpretation: it represents the count of pixels in a given image

;; Image -> Number
;; counts the number of pixels in a given image
;; (define (image-area img) 0)

;; given: an image with heigth of 100 pixels and width of 20 pixels, expected: 2000
;; given: an image with heigth of 100 pixels and width of 100 pixels, expected: 10000

;; (define (image-area img)
;;   (... img ...))

(define (image-area img)
  (* (image-height img)(image-width img)))
