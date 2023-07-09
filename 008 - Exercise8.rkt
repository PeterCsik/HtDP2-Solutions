(define picture ... )

(if (=(image-height picture)(image-width picture))
    "square"
    (if (>(image-height picture)(image-width picture))
        "tall"
        "wide"))

(cond [(=(image-height picture)(image-width picture)) "square"]
      [(>(image-height picture)(image-width picture)) "tall"]
      [else                                           "wide"])
