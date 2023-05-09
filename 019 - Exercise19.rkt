(define (string-insert str i)
  (cond
    [(and (> (string-length str) 0)(<= i (string-length str)))(string-append(substring str 0 (- i 1))"_"(substring str (- i 1)))]
    [(=(string-length str) 0) "Error: It is an empty string"]
    [(> i (string-length str))(string-append "Number "(number->string i)" is out of the valid range [0, " (number->string(string-length str)) "].")]
    ))
