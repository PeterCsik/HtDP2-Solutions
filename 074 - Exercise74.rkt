(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; a Posn represents the state of the world.

; Posn -> Image
; adds a red spot to MTS at p
;(define (scene+dot p) MTS)

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))

;(define (scene+dot p)
;  (... (posn-x p) ... (posn-y p) ...))

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))


; Posn -> Posn
; increases the x-coordinate of p by 3

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

;(define (x+ p)
;  (... (posn-x p) ... (posn-y p) ...))

(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


; Posn Number -> Posn
; produces a Posn like p with n in the x field  

(check-expect (posn-up-x (make-posn 10 0) 5) (make-posn 5 0))

;(define (posn-up-x p n)
;  (... n ... (posn-y p) ...))

(define (posn-up-x p n)
  (make-posn n (posn-y p)))


; Posn Number Number MouseEvt -> Posn
; for mouse clicks,  (make-posn x y); otherwise p
; (define (reset-dot p x y me) p)

(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down")
              (make-posn 29 31))

(check-expect (reset-dot (make-posn 10 20) 29 31 "button-up")
              (make-posn 10 20))

;(define (reset-dot p x y me)
;  (cond
;    [(mouse=? me "button-down") (... p ... x y ...)]
;    [else p]))

(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

; Posn -> Posn
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))
                             
