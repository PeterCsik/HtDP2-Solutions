(define-struct movie [title producer year])
(make-movie "Cube" "Mehra Meh, Betty Orr" 1997)

(define-struct person [name hair eyes phone])
(make-person "Adam" "gray" "green" "001-587-588")

(define-struct pet [name number])
(make-pet "Hugo" "25879")

(define-struct CD [artist title price])
(make-CD "Coldpla" "Music of the Spheres" "10.99") 

(define-struct sweater [material size producer])
(make-sweater "silk" "S" "Prada")
