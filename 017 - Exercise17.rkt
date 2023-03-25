(define (image-classify picture)(if (=(image-height picture)(image-width picture))
                                    "square"
                                    (if (>(image-height picture)(image-width picture))
                                        "tall"
                                        "wide")))
