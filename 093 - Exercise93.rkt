
; ---------- Constant definitions ----------

;; ---------- Cat and Scene ----------

(define CHAM .)       ; replace "." with an actual image

(define SCENE
  (beside(empty-scene (*(image-width CHAM) 5) (*(image-height CHAM) 1.1) "light yellow")
         (empty-scene (*(image-width CHAM) 5) (*(image-height CHAM) 1.1) "light green")
         (empty-scene (*(image-width CHAM) 5) (*(image-height CHAM) 1.1) "light blue")
         ))

(define X-CHAM                         ; the left-most edge of the CHAM
  (round(/ (image-width CHAM)2)))      ; round is needed because the modulo function used in our chameleon accepts only integers and not decimal numbers

(define Y-CHAM                         ; the y-coordinate of the CHAM in the BACKGROUND
  (/ (image-height CHAM)1.8))

(define CHAM-WIDTH                     ; the width of chameleon
  (- (image-width CHAM) 2))

(define CHAM-HEIGHT                    ; the height of chameleon
  (- (image-height CHAM) 2))

;; ---------- Gauge ----------

(define GAUGE-WIDTH 100)
(define GAUGE-HEIGHT 25)
(define GAUGE (rectangle GAUGE-WIDTH GAUGE-HEIGHT "outline" "black"))

; ---------- Data definitions ----------

(define-struct VCham (x happiness))
; A VCham is a structure:
;   (make-VCham Number Number)
; interpretation (make-VCham x h):
; -- keeps the chameleon's x-coordinate(in pixels from the left margin)
; -- its happiness (a number from 0 to 100)

(define ex1 (make-VCham 10 150))
(define ex2 (make-VCham 1 100))
(define ex3 (make-VCham 20 10))
(define ex4 (make-VCham 100 20))

; ---------- Function definitions ----------

; VCham -> Image
; Produces a red bar with a width according to the WorldState, interval [0, 100]
; (define (red-bar hc) img)

(check-expect (red-bar (make-VCham 10 100)) (rectangle 100 GAUGE-HEIGHT "solid" "red"))
(check-expect (red-bar (make-VCham 100 20)) (rectangle 20 GAUGE-HEIGHT "solid" "red"))
(check-expect (red-bar (make-VCham 100 300)) (rectangle 100 GAUGE-HEIGHT "solid" "red"))
(check-expect (red-bar (make-VCham 10 0)) (rectangle 0 GAUGE-HEIGHT "solid" "red"))

; (define (red-bar hc)       
;    (... (VCham-happiness hc) ...))

(define (red-bar hc)
  (rectangle
   (cond
     [(and(>(VCham-happiness hc)0)(< (VCham-happiness hc) 100)) (VCham-happiness hc)]
     [(<= (VCham-happiness hc) 0) 0]
     [(>= (VCham-happiness hc) 100) 100])
     GAUGE-HEIGHT "solid" "red"))

; VCham -> Image
; Places the cat into the SCENE according to the given world state.
; Whenever the chameleon disappears on the right, it reappears on the left.
; Part of the SCENE is a gauge that measures happiness level of the chameleon.
; (define (render hc) img)

(check-expect (render (make-VCham 10 100))
              (overlay/align "left" "top"
                             (red-bar (make-VCham 10 100))
                             (place-image CHAM(modulo(+ 10 X-CHAM)(image-width SCENE))Y-CHAM SCENE)))

(check-expect (render (make-VCham 0 100))
              (overlay/align "left" "top"
                             (red-bar (make-VCham 0 100))
                             (place-image CHAM (modulo(+ 0 X-CHAM)(image-width SCENE)) Y-CHAM SCENE)))
              
(check-expect (render (make-VCham 800 100))
              (overlay/align "left" "top"
                             (red-bar (make-VCham 800 100))
                             (place-image CHAM (modulo(+ 800 X-CHAM)(image-width SCENE)) Y-CHAM SCENE)))
  
; (define (render hc)
;   (... (VCham-x hc) ...))

(define (render hc)
  (overlay/align "left" "top"
                 (red-bar hc)
                 (place-image CHAM (modulo(+ (VCham-x hc) X-CHAM)(image-width SCENE)) Y-CHAM SCENE)))


; VCham -> VCham
; Moves the chameleon by 3 pixels for every clock tick.
; (define (tock hc) hc)

(check-expect (tock (make-VCham 10 100)) (make-VCham 13 99.9))
(check-expect (tock (make-VCham 0 100)) (make-VCham 3 99.9))

; (define (tock hc)
;   (... (VCham-x hc) ...))

(define (tock hc)
  (make-VCham(+ (VCham-x hc) 3) (- (VCham-happiness hc) 0.1)))


; VCham KeyEvent -> VCham
; Changes the level of chameleon's happiness by feeding chameleon.
; (define (handle-key hc ke) hc)

(check-expect (handle-key (make-VCham 0 80) "down") (make-VCham 0 (+ 80 2)))
(check-expect (handle-key (make-VCham 0 80) "up") (make-VCham 0 80))
(check-expect (handle-key (make-VCham 20 70) "g") (make-VCham 20 70))

; (define (handle-key hc ke)
;   (... (VCham-happiness hc) ... ke ...))

(define (handle-key hc ke)
  (cond
    [(key=? ke "down") (make-VCham (VCham-x hc)(+ (VCham-happiness hc) 2))]
    [else (make-VCham (VCham-x hc)(VCham-happiness hc))]
     ))


; VCham -> Boolean
; Stops rendering the red bar when the happines level is below 0, or above 100.
; (define (end? hc) #true)

(check-expect (end? (make-VCham 20 0)) #true)
(check-expect (end? (make-VCham 20 10)) #false)
(check-expect (end? (make-VCham 20 101)) #false)
(check-expect (end? (make-VCham 20 15)) #false)
   
; (define (end? hc)
;   (... VCham-happiness hc ...))

(define (end? hc)
  (<= (VCham-happiness hc) 0))


; ---------- Application ----------

(define (cham hc)
  (big-bang (make-VCham (VCham-x hc) 100)
    [to-draw render]
    [on-tick tock]
    [on-key handle-key]
    [stop-when end?]
  ))