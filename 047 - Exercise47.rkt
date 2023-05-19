; ---------- Constant definitions ----------

(define BACKGROUND-WIDTH 100)
(define BACKGROUND-HEIGHT 25)
(define BACKGROUND (rectangle BACKGROUND-WIDTH BACKGROUND-HEIGHT "outline" "black"))

; ---------- Data definition ----------

; WorldState is a Number. (cw)
; Interpretation: the number represents the current level of of happiness.

; ---------- Function definitions ----------

; WorldState -> Image
; Produces a red bar with a width according to the WorldState.
; (define (red-bar cw) img)

; given: 10, expected: (rectangle 10 BACKGROUND-HEIGHT "solid" "red"))
; given: 80, expected: (rectangle 150 BACKGROUND-HEIGHT "solid" "red"))

; (define (red-bar cw)       
;    (... cw ...))

(define (red-bar ws) (rectangle ws BACKGROUND-HEIGHT "solid" "red"))

(check-expect (red-bar 10) (rectangle 10 BACKGROUND-HEIGHT "solid" "red"))
(check-expect (red-bar 80) (rectangle 80 BACKGROUND-HEIGHT "solid" "red"))

; WorldState -> Image
; Produces a scene with a red bar in it based on the WorldState.
; (define (render cw) img)

; given: 10, expected: (overlay ... BACKGROUND (red-bar 10))
; given: 80, expected:  (overlay ... BACKGROUND (red-bar 80))

; (define (render cw)
;    (... cw ...))

(define (render cw) (overlay/align "left" "middle"
               BACKGROUND
               (red-bar cw)))

(check-expect (render 10) (overlay/align "left" "middle"
                            BACKGROUND
                            (red-bar 10)))
               
(check-expect (render 100) (overlay/align "left" "middle"
                            BACKGROUND
                            (red-bar 100)))

; WorldState -> WordlState
; Reduces the current WorldState by 0.1.
; (define (clock-tick cw) #i0)

; given: 1, expected: 0.9
; given: 5, expected: 4.9

; (define (clock-tick cw)
;    (... cw ...))

(define (clock-tick cw)
  (- cw 0.1))

(check-expect (clock-tick 1) (- 1 0.1))
(check-expect (clock-tick 5) (- 5 0.1))

; WorldState KeyEvent -> WordlState
; Changes the WorldState using up and down arrow key events.
; If the up arrow key is used, it increases the WorldState by 1/3.
; If the down arrow key is used, it decreases the WorldState by 1/5.
; (define (handle-key ws ke) #i0)

; given: 10 and up-arrow, expected: 10 + 1/3
; given: 10 and down-arrow, expected: 10 - 1/5

; (define (handle-key cw ke)
;   (... cw ... key ...))

(define (handle-key cw ke)
  (cond
    ((key=? ke "up") (+ cw 1/3))
    ((key=? ke "down") (- cw 1/5))
    (else cw)))

(check-expect (handle-key 10 "up") (+ 10 1/3))
(check-expect (handle-key 10 "down") (- 10 1/5))

; WorldState -> Boolean
; Stops rendering when Worldstate is below 0, or above 100.
; (define (end? cw) #false)

; given: -1, expected: #true
; given: 0, expected: #false
; given: 101, expected: #true
; given: 15, expected: #false
   
; (define (end? cw)
;   (... cw ...))

(define (end? cw)
  (or (> cw BACKGROUND-WIDTH)(< cw 0)))

(check-expect (end? -1) #true)
(check-expect (end? 0) #false)
(check-expect (end? 101) #true)
(check-expect (end? 15) #false)

; ---------- Application ----------

(define (gauge-prog cw)
  (big-bang 100
      [to-draw render]
      [on-tick clock-tick]
      [on-key handle-key]
      [stop-when end?]
  ))
