(define (string-insert str i)
  (if (string? str)
      (if(<= i (string-length str))
         (string-append(substring str 0 (- i 1))"_"(substring str (- i 1) (string-length str)))
         "Error: Maximum number allowed is the lenght of the given string.")
      "Error: Input a string and a number."))