(define in #false)

(if (string? in) (string-length in)
(if (image? in) (* (image-width in) (image-height in))
(if (boolean? in) (if in 10 20)
(if (and (number? in) (> in 0)) (- in 1) in))))

(cond                                                       ;; an  alternative solution using cond expressions
  [(string? in) (string-length in)]
  [(image? in) (* (image-width in)(image-height in))]
  [(boolean? in)
   (cond
     [(and in #true) 10]
     [else 20])]
  [(number? in)
   (cond
     [(> in 0) (- in 1)]
     [(<= in 0) in])]
  )
