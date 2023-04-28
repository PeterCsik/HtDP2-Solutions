(define CAT1 ...image1)
(define CAT2 ...image2)
(define CAT1-HEIGHT (image-height CAT1))
(define CAT1-WIDTH (image-width CAT1))

(define BACKGROUND (empty-scene (* CAT1-WIDTH 10) (+ CAT1-HEIGHT 10) ))
(define BACKGROUND-HEIGHT (image-height BACKGROUND))
(define BACKGROUND-WIDTH (image-width BACKGROUND))

;; WorldState is a Number
;; interpretation: the number of pixels between the left border of the background and the cat

;; Number -> Image
;; places the image of the cat x pixels from the left margin of the BACKGROUND image
;; if the x-coordinate is an odd number, use cat1 image, otherwise use cat2 image
; (define (render ws) img)      ; this is the stub

(check-expect (render 10)
              (cond
                [(odd? 10)(place-image CAT1 10 (/ BACKGROUND-HEIGHT 2) BACKGROUND)]
                [else (place-image CAT2 10 (/ BACKGROUND-HEIGHT 2) BACKGROUND)]))

(check-expect (render 11)
              (cond
                [(odd? 11)(place-image CAT1 11 (/ BACKGROUND-HEIGHT 2) BACKGROUND)]
                [else (place-image CAT2 11 (/ BACKGROUND-HEIGHT 2) BACKGROUND)]))

;(define (render ws)           ; this is the template
;    (BACKGROUND))

(define (render ws)
  (cond
  [(odd? ws)(place-image CAT1 (modulo ws BACKGROUND-WIDTH) (/ BACKGROUND-HEIGHT 2) BACKGROUND)]
  [else(place-image CAT2 (modulo ws BACKGROUND-WIDTH) (/ BACKGROUND-HEIGHT 2) BACKGROUND)]))


;; WorldState -> WordlState
;; moves the cat by 3 pixels for every clock tick
; (define (tock ws) 0)     ; this is the stub

(check-expect (tock 1) 4)
(check-expect (tock 0) 3)

; (define (tock ws)       ; this is the template
;    (... ws))

(define (tock ws)
  (+ ws 3))


;; WorldState -> Image
;; continuously moves the cat from left to right,
;; whenever the cat disappears on the right, it reappears on the left
; (define (cat-prog ws) img)    ; this the stub

; (define (cat-prog ws)         ; this is the template
;   (BACKGROUND))

(define (cat-prog ws)
  (big-bang ws
      [to-draw render]
      [on-tick tock]
  ))
