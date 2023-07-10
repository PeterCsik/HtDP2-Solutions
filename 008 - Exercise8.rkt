(define cat ... )
(if (=(image-height picture)(image-width picture))
    "square"
    (if (>(image-height picture)(image-width picture))
        "tall"
        "wide"))

(define cat1 ...)                                                    ; an alternative solution
(cond [(=(image-height picture)(image-width picture)) "square"]
      [(>(image-height picture)(image-width picture)) "tall"]
      [else                                           "wide"])
