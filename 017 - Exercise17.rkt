(define (image-classify picture)
  (if (=(image-height picture)(image-width picture))
      "square"
      (if (>(image-height picture)(image-width picture))
          "tall"
          "wide")))



(define (image-classify picture)                             
  (cond [(=(image-height picture)(image-width picture))"square"]
        [(>(image-height picture)(image-width picture))"tall"]
        [(<(image-height picture)(image-width picture))"wide"]))
