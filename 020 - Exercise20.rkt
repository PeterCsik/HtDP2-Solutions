(define (string-delete str i)
  (string-append(substring str 0 i)""(substring str (+ i 1) (string-length str))))
