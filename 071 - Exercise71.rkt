; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

; -- evaluation --

(game-ball game0)
; == DrRacket replaces all constants with values
; == DrRacket replaces game0 with
(game-ball
 (make-game 100 100 (make-posn 200 200)))
; == DrRacket uses the law for game-ball
(make-posn 200 200)

(posn? (game-ball game0))
; == DrRacket replaces all constants with values
; == DrRacket replaces game0 with
(posn?
 (game-ball
 (make-game 100 100 (make-posn 200 200)))
; == DrRacket uses the law for game-ball
 (posn? (make-posn 200 200))
; == DrRacket evalues the expression
 #true

(game-left-player game0)
; == DrRacket replaces all constants with values
; == DrRacket replaces game0 with
(game-left-player
 (make-game 100 100 (make-posn 200 200)))
; == DrRacket uses the law for game-left-player
100
