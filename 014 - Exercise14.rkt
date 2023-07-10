(define (string-last x)
  (if(> (string-length x) 0)
     (string-ith x (- (string-length x) 1))
     #false))
