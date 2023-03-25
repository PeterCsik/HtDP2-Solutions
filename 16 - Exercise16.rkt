(define (image-area picture)(if (image? picture)
                                (*(image-width picture)(image-height picture))
                                "Error: The input is not an image."))
