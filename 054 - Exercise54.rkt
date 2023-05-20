(define (show x)
  (cond
    [(string? x) ...]             ; It would be incorrect to use (string? x) condition, because big-bang function accepts only Number for a WorldState (x) 
    [(<= -3 x -1) ...]
    [(>= x 0) ...]))
 
 
 (define (show x)
  (cond
    [(zero? x) ...]               ; To represent "resting" with a Number (instead of a String) is to use 0 for WorldState 
    [(<= -3 x -1) ...]
    [(>= x 0) ...]))
