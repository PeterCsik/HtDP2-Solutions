(define (string-insert str i)
  (string-append (substring str 0 (- i 1))
                 "_"
                 (substring str (- i 1))))
