(define (in x)
(cond [(string? x) (string-length x)]
      [(image? x)  (* (image-width x)(image-height x))]
      [(boolean? x)
       (cond [(and x #true) 10]
             [else          20])]
      [(number? x)
       (cond [(> x 0) (- x 1)]
             [(<= x 0) x])]))
