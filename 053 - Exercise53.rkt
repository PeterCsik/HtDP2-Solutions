; ---------- Constant definitions ----------

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 10 50 "solid" "red"))

; ---------- Data definitions ----------

; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; Interpretation: "resting" represents a grounded rocket,
; a number denotes the height of a rocket in flight.

; a "resting" position example
(place-image ROCKET (/ WIDTH 2) HEIGHT BACKG)      ; (/ WIDTH 2) is used to make the resting position of ROCKET in the bottom-center of the BACKG

; flying rocket examples
(place-image ROCKET (/ WIDTH 2) 250 BACKG)
(place-image ROCKET (/ WIDTH 2) 200 BACKG)
(place-image ROCKET (/ WIDTH 2) 150 BACKG)
(place-image ROCKET (/ WIDTH 2) 100 BACKG)
(place-image ROCKET (/ WIDTH 2) 50 BACKG)
(place-image ROCKET (/ WIDTH 2) 0 BACKG)