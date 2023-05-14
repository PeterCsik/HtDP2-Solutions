; ---------- Constant definitions ----------
(define CAT1 .)

(define BACKGROUND
  (empty-scene (*(image-width CAT1) 10) (*(image-height CAT1) 1.1)))

(define X-CAT1
  (round(/ (image-width CAT1)2)))

(define Y-CAT1
  (/ (image-height CAT1)1.8))

; ---------- Function definitions ----------

; A WorldState is a Number. (cw)
; Interpretation: the number of pixels between the left border of the scene and the left-most edge of the cat.

; WorldState -> Image
; Places the cat into the BACKGROUND according to the given world state.
; Whenever the cat disappears on the right, it reappears on the left.
; (define (render cw)
;   (... modulo cw ...))

; given: 10, expected 48
; given: 0, expected 38
; given: 800, expected 88

(define (render cw)
  (place-image CAT1 (modulo(+ cw X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))

(check-expect (render 10) (place-image CAT1 (modulo (+ 10 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))
(check-expect (render 0) (place-image CAT1 (modulo (+ 0 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))
(check-expect (render 800) (place-image CAT1 (modulo (+ 800 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))

; WorldState -> WorldState
; Moves the cat by 3 pixels for every clock tick.
; (define (tock cw) 0)

; given: 10, expected 13
; given: 0, expected 3

; (define (tock cw)
;   (... cw ...))

(define (tock cw)
  (+ cw 3))

(check-expect (tock 10) 13)
(check-expect (tock 0) 3)


; ---------- Application ----------

(define (cat-prog cw)
  (big-bang cw
    [to-draw render]
    [on-tick tock]
  ))
