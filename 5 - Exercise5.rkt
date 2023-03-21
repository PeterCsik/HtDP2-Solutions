(define (boat x) (above (triangle x "solid" "green")
         (beside
               (triangle/sas x 90 x "solid" "green")
               (rectangle (* x 2) x "solid" "brown")
               (triangle/asa 90 x 45 "solid" "green"))))
