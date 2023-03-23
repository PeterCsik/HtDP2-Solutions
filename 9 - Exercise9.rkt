(define in #false)

(if (string? in) (string-length in)
(if (image? in) (* (image-width in) (image-height in))
(if (boolean? in) (if (and in #true) 10 20)
(if (and (number? in) (> in 0)) (- in 1) in))))
