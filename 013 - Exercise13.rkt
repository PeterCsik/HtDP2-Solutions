(define (string-first x)
  (if (string? x) (if(> (string-length x) 0) 
                        (string-ith x 0) 
                        "Error: It is an empty string.") 
                              "Error: It is not a string."))

(define (string-first x)
  (cond
    [(string? x)
         (cond
           [(> (string-length x) 0) (string-ith x 0)]
           [(= (string-length x) 0) "Error: It is an empty string."])]
    [else "Error: It is not a string."]
    )
  )
