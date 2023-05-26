; ---------- Constant definitions ----------

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; ---------- Data definitions ----------

; A DoorState is one of:
; –- LOCKED
; –- CLOSED
; –- OPEN

; ---------- Function definitions ----------

; DoorState -> DoorState
; closes an open door over the period of one click
; (define (door-closer state-of-door) state-of-door)

; given state: LOCKED, desired state: LOCKED
; given state: CLOSED, desired state: CLOSED
; given state: OPEN, desired state: CLOSED

;(define (door-closer state-of-door)
;  (cond
;    [(string=? LOCKED state-of-door) ...]
;    [(string=? CLOSED state-of-door) ...]
;    [(string=? OPEN state-of-door) ...]
;    ))

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]
    ))

(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)

; DoorState KeyEvent -> DoorState
; turns key event k into an action on state s
; (define (door-action s k) s)

; given state: LOCKED, given key event: "u", desired state: CLOSED
; given state: CLOSED, given key event: "l", desired state: LOCKED
; given state: CLOSED, given key event: " ", desired state: OPEN
; given state: OPEN, given key event: -, desired state: OPEN

;(define (door-action s k)
;  (cond
;    [(and (string=? LOCKED s) (string=? "u" k))...]
;    [(and (string=? CLOSED s) (string=? "l" k))...]
;    [(and (string=? CLOSED s) (string=? " " k))...]
;    [else s]))

(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k))CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k))LOCKED]
    [(and (string=? CLOSED s) (string=? " " k))OPEN]
    [else s]))

(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

; DoorState -> Image
; translates the state s into a large text image
; (define (door-render s) img)

; given state: LOCKED, expected: text LOCKED red
; given state: CLOSED, expected: text CLOSED red
; given state: OPEN, expected: text OPEN red

;(define (door-render s)
;  (... s ...))

(define (door-render s)
  (text s 40 "red"))

(check-expect (door-render LOCKED) (text "locked" 40 "red"))
(check-expect (door-render CLOSED) (text "closed" 40 "red"))
(check-expect (door-render OPEN) (text "open" 40 "red"))

; ---------- Application ----------

; DoorState -> DoorState
; simulates a door with an automatic door closer

(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]
    ))
