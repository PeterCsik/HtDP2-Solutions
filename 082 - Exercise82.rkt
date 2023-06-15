(define-struct tlw [first-letter second-letter third-letter])
; A Tlw is a structure:
;   (make-tlw 1String 1String 1String)
; interpretation represents a three-letter word that consist of
; lowercase letters "a" through "z" or #false

(define ex1 (make-tlw "f" "o" "x"))
(define ex2 (make-tlw "b" "y" #false))
(define ex3 (make-tlw "b" "o" "y"))

; tlw tlw -> String
; consumes two tlws and
; it produces a word that indicates where the given ones agree and disagree,
; it retains the content of the structure fields if two agree, otherwise
; it places #false in the field of the resulting word
; (define (compare-word m n) "a"))

; (check-expect (compare-word ex1 ex1) "fox")
; (check-expect (compare-word ex1 ex3) "#false o #false")

; (define (compare-words m n)
;   (... (tlw-first-letter m) ... (tlw-second-letter m)
;        ... (tlw-third-letter m)
;        ... (tlw-first-letter n) ... (tlw-second-letter n)
;        ... (tlw-third-letter n) ...))

(define (compare-word m n)
  (cond
    [(equal? m n) (string-append (tlw-first-letter m)(tlw-second-letter m)(tlw-third-letter m))]
    [else
     (string-append ""
                    (if (equal? (tlw-first-letter m) (tlw-first-letter n))(tlw-first-letter n) "#false")
                    " "
                    (if (equal? (tlw-second-letter m) (tlw-second-letter n))(tlw-second-letter n)"#false")
                    " "
                    (if (equal? (tlw-third-letter m) (tlw-third-letter n)) (tlw-third-letter n)"#false"))]
    ))
                    
