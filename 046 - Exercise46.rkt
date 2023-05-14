; ---------- Constant definitions ----------
(define CAT1 .)
(define CAT2 .)

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


; given: 11, expected CAT2 and 49
; given: 1, expected CAT2 and 39
; given: 801, expected CAT 2 and 89

; given: 10, expected CAT2 and 48
; given: 0, expected CAT2 and 38
; given: 800, expected CAT 2 and 88

(define (render cw)
  (place-image
   (cond [(odd? cw) CAT1]
         [(even? cw) CAT2])
         (modulo(+ cw X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))

(check-expect (render 11) (place-image CAT1 (modulo (+ 11 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))
(check-expect (render 1) (place-image CAT1 (modulo (+ 1 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))
(check-expect (render 801) (place-image CAT1 (modulo (+ 801 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))

(check-expect (render 10) (place-image CAT2 (modulo (+ 10 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))
(check-expect (render 0) (place-image CAT2 (modulo (+ 0 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))
(check-expect (render 800) (place-image CAT2 (modulo (+ 800 X-CAT1)(image-width BACKGROUND)) Y-CAT1 BACKGROUND))

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
