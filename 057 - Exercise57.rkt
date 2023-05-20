; ---------- Constant definitions ----------

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 10 50 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; ---------- Data definitions ----------

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
;Interpretation: "resting" represents a grounded rocket,
; in countdown mode, a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

; ---------- Function definitions ----------

; LRCD -> Image
; Renders the state as a resting or flying rocket.
; (define (show x) BACKG)

; given: "resting", expected: (place-image ROCKET 50 275 BACKG)
; given: [-3,-1], expected: "resting" with a countdown (text [-3,-1] ... ...)
; given: >= 0, (place-image ROCKET 50 (- 275 0) BACKG)

; (define (show x)
;    ( ... x ...))

 (define (show x)
  (cond
   [(string? x) (distance-rocket 0)]
    [(<= -3 x -1)(overlay/align "center" "middle"
                    (text (number->string x) 60 "gray")
                    (distance-rocket 0))]
    [(>= x 0) (distance-rocket x)]))

(define (distance-rocket x)                                                    ; an auxiliary function used in "show" function
  (place-image ROCKET (/ WIDTH 2) (+ HEIGHT (* x -1) (* CENTER -1)) BACKG))    ; it measures the distance between the ground and the bottom of the rocket

(check-expect (show "resting")(distance-rocket 0))
(check-expect (show -3)(overlay/align "center" "middle" (text (number->string -3) 60 "gray") (distance-rocket 0)))
(check-expect (show 5) (distance-rocket 5))

; LRCD KeyEvent -> LRCD
; Starts the countdown when space bar is pressed,
; if the rocket is still resting
; (define (launch x ke) 0 str)

; given: "resting" " ", expected: -3
; given: "resting" "a", expected: "resting"
; given: -3 " ", expected: -3
; given: -2 " ", expected: -2
; given: -1 " ", expected: -1
; given: 33 " ", expected: 33
; givne: 33 "a", expected: 33

; (define (launch x ke)
;    ( ... x ... ke ...))

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -2 " ") -2)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

; LRCD -> LRCD
; Raises the rocket by YDELTA if it is moving already.
; (define (fly x) 0)

; given: "resting", expected: "resting"
; given: -3, expected: -2
; given: -2, expected: -1
; given: -1, expected: HEIGHT
; given: 10, expected: (+ 10 YDELTA)
; given: 22, expected: (+ 22 YDELTA)

; (define (fly x)
;   (... x ...)

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) 0 (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))

; LRCD -> Boolean
; Stops the program when the rocket dissapears on the top of BACKG.
; (define (end? y) #true)

; given: 50, expected: #false
; given: 300, expected: #true

; (define (end? y)
;   (... y ...))

(define (end? x)
  (cond
    [(number? x) (if (> x HEIGHT) #true #false)]
    [else #false]
    ))

(check-expect (end? 50) #false)
(check-expect (end? 350) #true)
(check-expect (end? "a") #false)
 
; ---------- Application ----------

(define (main x)
  (big-bang "resting"
    [on-key launch]
    [to-draw show]
    [on-tick fly 0.3]
    [stop-when end?]
    ))
