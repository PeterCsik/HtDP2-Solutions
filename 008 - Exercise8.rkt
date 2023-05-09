(define picture ... )

(if (=(image-height picture)(image-width picture)) "square"
(if (>(image-height picture)(image-width picture))"tall" "wide"))

(cond                                                                    ;; an alternative solution using cond expressions
    [ (=(image-height picture)(image-width picture)) "square"]
    [ (>(image-height picture)(image-width picture)) "tall"]
    [ else "wide"])
