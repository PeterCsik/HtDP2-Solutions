(define (show x)
  (cond
    [(string? x) ...]             ; It would be incorrect to use (string=? "resting" x) condition, because the condition would accept only "resting" word as an input. 
    [(<= -3 x -1) ...]            ; Using (string? x) condition is more flexible, it accepts any string, even an empty string.
    [(>= x 0) ...]))
