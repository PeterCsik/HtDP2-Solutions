(define BOAT-SIZE 50)

(above (triangle (* BOAT-SIZE 3) "solid" "grey")
       (beside (triangle/sas BOAT-SIZE 90 BOAT-SIZE "solid" "brown")
               (rectangle (* BOAT-SIZE 5) BOAT-SIZE "solid" "brown")
               (triangle/asa 90 BOAT-SIZE 45 "solid" "brown")))
