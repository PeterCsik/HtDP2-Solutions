(define (string-join string1 string2) (if(and(string? string1) (string? string2))
                                         (string-append string1 "_" string2)
                                         "Error: One of the or both of the inputs are not strings."))
