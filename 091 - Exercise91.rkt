; ---------- Constant definitions ----------

;; ---------- Cat and Scene ----------

(define CAT1 .)       ; replace "." with an actual image

(define SCENE
  (empty-scene (*(image-width CAT1) 10) (*(image-height CAT1) 1.1)))

(define X-CAT1                          ; the left-most edge of the CAT1
  (round(/ (image-width CAT1)2)))       ; round is needed because the modulo function used in our happy-cat accepts only integers and not decimal numbers

(define Y-CAT1                          ; the y-coordinate of the CAT1 in the BACKGROUND
  (/ (image-height CAT1)1.8))

;; ---------- Gauge ----------

(define GAUGE-WIDTH 100)
(define GAUGE-HEIGHT 25)
(define GAUGE (rectangle GAUGE-WIDTH GAUGE-HEIGHT "outline" "black"))

; ---------- Data definitions ----------

(define-struct VCat (x happiness direction))
; A VCat is a structure:
;   (make-VCat Number Number)
; interpretation (make-VCat x h d) keeps the cat's x-coordinate
; (in pixels from the left margin), its happiness
; (a number from 0 to 100), and its direction ("left" or "right")

(define ex0 (make-VCat 0 100 "right"))
(define ex1 (make-VCat 10 100 "left"))
(define ex2 (make-VCat 1 100 "right"))
(define ex3 (make-VCat 20 10 "right"))
(define ex4 (make-VCat 100 20 "left"))
(define ex5 (make-VCat 740 50 "left"))
(define ex6 (make-VCat 750 80 "left"))

; ---------- Function definitions ----------

; VCat -> Image
; Produces a red bar with a width according to the WorldState.
; (define (red-bar hc) img)

(check-expect (red-bar (make-VCat 10 100 "left")) (rectangle 100 GAUGE-HEIGHT "solid" "red"))
(check-expect (red-bar (make-VCat 100 20 "left")) (rectangle 20 GAUGE-HEIGHT "solid" "red"))

; (define (red-bar hc)       
;    (... (VCat-happiness hc) ...))

(define (red-bar hc)
  (rectangle (VCat-happiness hc) GAUGE-HEIGHT "solid" "red"))

; VCat -> Image
; Places the cat into the SCENE according to the given world state.
; Whenever the cat disappears on the right, it reappears on the left.
; Part of the SCENE is a gauge that measures happiness level of the cat.
; (define (render hc) img)

(check-expect (render (make-VCat 10 100 "left"))
              (overlay/align "left" "top"
                             (red-bar (make-VCat 10 100 "left"))
                             (place-image CAT1 (+ 10 X-CAT1) Y-CAT1 SCENE)))

(check-expect (render (make-VCat 0 100 "right"))
              (overlay/align "left" "top"
                             (red-bar (make-VCat 0 100 "right"))
                             (place-image CAT1 (+ 0 X-CAT1) Y-CAT1 SCENE)))
              
(check-expect (render (make-VCat 800 100 "left"))
              (overlay/align "left" "top"
                             (red-bar (make-VCat 750 100 "left"))
                             (place-image CAT1 (+ 800 X-CAT1) Y-CAT1 SCENE)))
  
; (define (render hc)
;   (... (VCat-x hc) ...
;     (VCat-direction hc) ...))

(define (render hc)
  (overlay/align "left" "top"
                 (red-bar hc)
                 (place-image CAT1 (+(VCat-x hc) X-CAT1) Y-CAT1 SCENE)))


; VCat -> VCat
; Moves the cat by 3 pixels for every clock tick.
; (define (tock hc) hc)

;(check-expect (tock (make-VCat 10 100 "left")) (make-VCat 13 99.9 "left"))
;(check-expect (tock (make-VCat 0 100 "right")) (make-VCat 3 99.9 "right"))

; (define (tock hc)
;   (... (VCat-x hc) ... (VCat-happiness hc) ...
;      (Vcat-direction hc)...))

(define (tock hc)
  (cond
    [(string=? (VCat-direction hc) "right")
     (make-VCat(+ (VCat-x hc) 3) (- (VCat-happiness hc) 0.1) (if(>=(+ (VCat-x hc) (image-width CAT1)) 750) "left" "right"))]
    [(string=? (VCat-direction hc) "left")
     (make-VCat(+ (VCat-x hc) -3) (- (VCat-happiness hc) 0.1) (if(<=(VCat-x hc) 0) "right" "left"))]
          ))


; VCat KeyEvent -> VCat
; Changes the level of cat's happiness using up and down arrow key events.
; If the up arrow key is used, it increases the happiness level by 1/3.
; If the down arrow key is used, it decreases the happiness level by 1/5.
; (define (handle-key hc ke) hc)

(check-expect (handle-key (make-VCat 10 100 "left") "up") (make-VCat 10 (+ 100 1/3) "left"))
(check-expect (handle-key (make-VCat 0 100 "right") "down") (make-VCat 0 (- 100 1/5) "right"))

; (define (handle-key hc ke)
;   (... (VCat-x hc) ... (VCat-happiness hc)
;      ... (Vcat-direction hc)... ke ...))

(define (handle-key hc ke)
  (cond
    [(key=? ke "up") (make-VCat (VCat-x hc)(+ (VCat-happiness hc) 1/3)(VCat-direction hc))]
    [(key=? ke "down") (make-VCat (VCat-x hc)(- (VCat-happiness hc) 1/5)(VCat-direction hc))]
    [else (make-VCat (VCat-x hc)(VCat-happiness hc)(VCat-direction hc))]
     ))


; ---------- Application ----------

(define (happy-cat hc)
  (big-bang (make-VCat (VCat-x hc) 100 (VCat-direction hc))
    [to-draw render]
    [on-tick tock]
    [on-key handle-key]
  ))
