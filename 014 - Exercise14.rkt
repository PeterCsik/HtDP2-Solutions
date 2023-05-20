(define (string-last x) (if (string? x) 
                              (if(> (string-length x) 0) 
                                      (string-ith x (- (string-length x) 1)) 
                                      "Error: It is an empty string.") 
                              "Error: It is not a string."))

(define (string-last x)                         ; an alternative solution using cond expressions
  (cond
    [(string? x)
         (cond
           [(> (string-length x) 0) (string-ith x (- (string-length x)1))]
           [(= (string-length x) 0) "Error: It is an empty string."])]
       [ else "Error: It is not a string."]
    )
  )
