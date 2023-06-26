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

(define-struct VCat (x happiness))
; A VCat is a structure:
;   (make-VCat Number Number)
; interpretation (make-VCat x h) keeps the cat's x-coordinate
; (in pixels from the left margin), and its happiness
; (a number from 0 to 100)

(define ex1 (make-VCat 10 100))
(define ex2 (make-VCat 1 100))
(define ex3 (make-VCat 20 10))
(define ex4 (make-VCat 100 20))

; ---------- Function definitions ----------

; VCat -> Image
; Produces a red bar with a width according to the WorldState.
; (define (red-bar hc) img)

(check-expect (red-bar (make-VCat 10 100)) (rectangle 100 GAUGE-HEIGHT "solid" "red"))
(check-expect (red-bar (make-VCat 100 20)) (rectangle 20 GAUGE-HEIGHT "solid" "red"))

; (define (red-bar hc)       
;    (... (VCat-happiness hc) ...))

(define (red-bar hc)
  (rectangle (VCat-happiness hc) GAUGE-HEIGHT "solid" "red"))

; VCat -> Image
; Places the cat into the SCENE according to the given world state.
; Whenever the cat disappears on the right, it reappears on the left.
; Part of the SCENE is a gauge that measures happiness level of the cat.
; (define (render hc) img)

(check-expect (render (make-VCat 10 100))
              (overlay/align "left" "top"
                             (red-bar (make-VCat 10 100))
                             (place-image CAT1 (modulo (+ 10 X-CAT1)(image-width SCENE)) Y-CAT1 SCENE)))

(check-expect (render (make-VCat 0 100))
              (overlay/align "left" "top"
                             (red-bar (make-VCat 0 100))
                             (place-image CAT1 (modulo (+ 0 X-CAT1)(image-width SCENE)) Y-CAT1 SCENE)))
              
(check-expect (render (make-VCat 800 100))
              (overlay/align "left" "top"
                             (red-bar (make-VCat 800 100))
                             (place-image CAT1 (modulo (+ 800 X-CAT1)(image-width SCENE)) Y-CAT1 SCENE)))
  
; (define (render hc)
;   (... (VCat-x hc) ...))

(define (render hc)
  (overlay/align "left" "top"
                 (red-bar hc)
                 (place-image CAT1 (modulo(+ (VCat-x hc) X-CAT1)(image-width SCENE)) Y-CAT1 SCENE)))


; VCat -> VCat
; Moves the cat by 3 pixels for every clock tick.
; (define (tock hc) hc)

(check-expect (tock (make-VCat 10 100)) (make-VCat 13 99.9))
(check-expect (tock (make-VCat 0 100)) (make-VCat 3 99.9))

; (define (tock hc)
;   (... (VCat-x hc) ...))

(define (tock hc)
  (make-VCat(+ (VCat-x hc) 3) (- (VCat-happiness hc) 0.1)))


; VCat KeyEvent -> VCat
; Changes the level of cat's happiness using up and down arrow key events.
; If the up arrow key is used, it increases the happiness level by 1/3.
; If the down arrow key is used, it decreases the happiness level by 1/5.
; (define (handle-key hc ke) hc)

(check-expect (handle-key (make-VCat 10 100) "up") (make-VCat 10 (+ 100 1/3)))
(check-expect (handle-key (make-VCat 0 100) "down") (make-VCat 0 (- 100 1/5)))

; (define (handle-key hc ke)
;   (... (VCat-happiness hc) ... ke ...))

(define (handle-key hc ke)
  (cond
    [(key=? ke "up") (make-VCat (VCat-x hc)(+ (VCat-happiness hc) 1/3))]
    [(key=? ke "down") (make-VCat (VCat-x hc)(- (VCat-happiness hc) 1/5))]
    [else (make-VCat (VCat-x hc)(VCat-happiness hc))]
     ))


; VCat -> Boolean
; Stops rendering the red bar when the happines level is below 0, or above 100.
; (define (end? hc) #true)

(check-expect (end? (make-VCat 20 0)) #true)
(check-expect (end? (make-VCat 20 10)) #false)
(check-expect (end? (make-VCat 20 101)) #false)
(check-expect (end? (make-VCat 20 15)) #false)
   
; (define (end? hc)
;   (... VCat-happiness hc ...))

(define (end? hc)
  (<= (VCat-happiness hc) 0))


; ---------- Application ----------

(define (happy-cat hc)
  (big-bang (make-VCat (VCat-x hc) 100)
    [to-draw render]
    [on-tick tock]
    [on-key handle-key]
    [stop-when end?]
  ))
