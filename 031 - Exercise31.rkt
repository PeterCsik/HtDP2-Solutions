(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    (body fst lst)
    (closing signature-name)))
 
(define (opening fst)
  (string-append "Dear " fst ", "))
 
(define (body fst lst)
  (string-append
   "We have discovered that all people with the "
   "last name " lst " have won our lottery. So, "
   fst ", " "hurry and pick up your prize. "))
 
(define (closing signature-name)
  (string-append
   "Sincerely, "
   signature-name
    ))

(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

(write-file "fst" "Tony")
(write-file "lst" "Holland")
(write-file "signature" "Claire")

(main "fst" "lst" "signature" "out.file")
(read-file "out.file")
