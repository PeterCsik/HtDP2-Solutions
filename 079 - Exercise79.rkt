; A Color is one of: 
; --- "white"
; --- "yellow"
; --- "orange"
; --- "green"
; --- "red"
; --- "blue"
; --- "black"

"black"
"white"
"green"
"orange"
"red"


; H is a Number between 0 and 100.
; interpretation represents a happiness value

0
38
100
12
78


(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

(make-person "Helen" "Doron" #false)
(make-person "John" "Jones" #true)
(make-person "Henry" "Smith" #true)
(make-person "Harper" "Kelly" #false)

; Question: Is it a good idea to use a field name
; that looks like the name of a predicate?
; Answer: I find it to be an option if one is interested in
; a specific "Yes/No" type of question. Like in the examples below,
; where we are specifically interested in whether the person is
; a male or not.
(define club-member (make-person "John" "Jones" "#true"))
(person-male? club-member)


(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; interpretation is a registration data of a dog that
; includes owner's name, dog's name and its age and
; its happines level

(make-dog "Adam Torres" "Billy" 3 "H3")
(make-dog "Hellen Doron" "JayK" 8 "H1")
(make-dog "Harper Kelly" "Max" 15 "H5")
(make-dog "Harper Crow" "Pat" 1 "H5")
(make-dog "Julian Johnson" "King4" 11 "H2")
 

; A Weapon is one of: 
; --- #false
; --- Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

#false
(make-posn 4 5)
(make-posn 120 5)
(make-posn 230 44)
(make-posn 34 120)
