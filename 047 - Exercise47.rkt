(define BACKGROUND-HEIGHT 25)
(define BACKGROUND-WIDTH 100)
(define BACKGROUND (rectangle BACKGROUND-WIDTH BACKGROUND-HEIGHT "outline" "black"))


;; WorldState is a number. (ws)
;; interpretation represents the current level of of happiness


;; WorldState -> Image
;; produces a red bar based on the WorldState
; (define (red-bar ws) img)    ; this is the stub

(check-expect (red-bar 10) (rectangle 10 25 "solid" "red"))
(check-expect (red-bar 150) (rectangle 150 25 "solid" "red"))

; (define (red-bar ws)        ; this is the template
;    (...img))

(define (red-bar ws) (rectangle ws BACKGROUND-HEIGHT "solid" "red"))


;; WorldState -> Image
;; produces a scene with red bar based on the WorldState
; (define (scene ws) img)    ; this is the stub

(check-expect (scene 10) (overlay/align "left" "middle"
                            BACKGROUND
                            (red-bar 10)))
               
(check-expect (scene 100) (overlay/align "left" "middle"
                            BACKGROUND
                            (red-bar 100)))

; (define (scene ws)        ; this is the template
;    (...img))

(define (scene ws) (overlay/align "left" "middle"
               BACKGROUND
               (red-bar ws)))


;; Worldstate -> Image
;; changes width of the red bar in the scene based on the WorldState 
; (define (render ws) img)     ; this is the stub

(check-expect (render 10)(scene 10))
(check-expect (render 100) (scene 100))

; (define (render ws)         ; this is the template
;   (...scene))

(define (render ws)
  (scene ws))


;; WorldState -> WordlState
;; reduces the current WorldState by 0.1
; (define (clock-tick ws) #i0)     ; this is the stub

(check-expect (clock-tick 1) (- 1 0.1))
(check-expect (clock-tick 5) (- 5 0.1))

; (define (clock-tick ws)       ; this is the template
;    (... ws))

(define (clock-tick ws)
  (- ws 0.1))


;; WorldState KeyEvent -> WordlState
;; changes the WorldState using up and down arrow key events
;; if the up arrow key is used, it increases the WorldState by 1/3
;; if the down arrow key is used, it decreases the WorldState by 1/5
; (define (handle-key ws ke) #i0)     ; this is the stub

(check-expect (handle-key 10 "up") (+ 10 1/3))
(check-expect (handle-key 10 "down") (- 10 1/5))

; (define (handle-key ws ke)          ; this is the template
;           (...ws))

(define (handle-key ws ke)
  (cond
    ((key=? ke "up") (+ ws 1/3))
    ((key=? ke "down") (- ws 1/5))
    (else ws)))


;; end?
;; WorldState -> Boolean
;; stops renedering when Worldstate is below 0, or above 100
;; (define (end? ws) #false)    ; this is the stub

(check-expect (end? 0) #false)
(check-expect (end? 101) #true)
(check-expect (end? 15) #false)
   
; (define (end? ws)             ; this is the templates
;     (... ws))

(define (end? ws)
  (or (> ws BACKGROUND-WIDTH)(< ws 0)))


;; WorldState -> WordlState
;; consumes the current level of happiness

(define (gauge-prog ws)
  (big-bang ws
      [to-draw render]
      [on-tick clock-tick]
      [on-key handle-key]
      [stop-when end?]
  ))
