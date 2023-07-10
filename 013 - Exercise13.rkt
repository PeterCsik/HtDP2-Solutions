(define (string-first x)
  (if (> (string-length x) 0)
      (string-ith x 0)
      #false))
