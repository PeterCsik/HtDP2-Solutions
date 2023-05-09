(define (string-delete str i)
  (cond
    [(or (< i 0)(>= i (string-length str)))(string-append "Number "(number->string i)" is out of the valid range [0, " (number->string(-(string-length str)1)) "].")]
    [(=(string-length str) 0) "Error: It is an empty string"]
    [(and (> (string-length str) 0)(<= i (string-length str)))(string-append(substring str 0 i)""(substring str (+ i 1) (string-length str)))]
    ))
