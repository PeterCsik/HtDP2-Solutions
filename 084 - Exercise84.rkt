; ---------- Data definitions ----------

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-apend s t) with
; the cursor displayed between s and t

(define ed1 (make-editor "hello" "world"))
(define ed2 (make-editor "Silicon" "Valley"))
(define ed3 (make-editor "Knight" "Rider"))


; A KeyEvent is one of:
; -- the single character "a" through "z"
; -- the backspace "\b"
; -- left arrow
; -- right arrow

; ---------- Function definitions ----------

; Editor KeyEvent -> Editor
; -- adds a charachater,
; -- deletes a character,
; -- moves the cursor to the left
; -- moves the cursor to the right
; (define (edit ed ke) (make-editor s t))

; (define (edit ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(check-expect (edit (make-editor "hello" "world") "\b") (make-editor "hell" "world"))
(check-expect (edit (make-editor "hello" "world") "a") (make-editor "helloa" "world"))
(check-expect (move-cursor-left (make-editor "hello" "world")) (make-editor "hell" "oworld"))
(check-expect (move-cursor-right (make-editor "hello" "world")) (make-editor "hellow" "orld"))

(define (edit ed ke)
  (cond
    [(key=? ke "\b") (delete-character ed)]
    [(= (string-length ke) 1) (add-character ed ke)]
    [(key=? ke "left") (move-cursor-left ed)]
    [(key=? ke "right") (move-cursor-right ed)]
        ))

;; ---------- Function definitions (Auxiliarry functions) ----------

; Editor KeyEevent -> Editor
; adds a single-character to the end of the pre field of ed
; (define (add-character ed ke) (make-editor s t))

(check-expect (add-character (make-editor "hello" "world") "a") (make-editor "helloa" "world"))

; (define (add-character ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (add-character ed ke)
  (make-editor (string-append (editor-pre ed) ke) (editor-post ed)))


; Editor -> Editor
; deletes the character immediatelly to the left  of the cursor
; (define (delete-character ed) (make-editor s t))

(check-expect (delete-character (make-editor "hello" "world")) (make-editor "hell" "world"))

; (define (delete-character ed)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (delete-character ed)
  (make-editor (substring (editor-pre ed) 0 (-(string-length (editor-pre ed)) 1)) (editor-post ed)))


; Editor KeyEvent -> Editor
; moves the cursor one character to the left (if any)
; (define (move-cursor-left ed ke) (make-editor ed ke))

(check-expect (move-cursor-left (make-editor "hello" "world")) (make-editor "hell" "oworld"))

; (define (move-cursor-left ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (move-cursor-left ed)
  (make-editor (substring (editor-pre ed) 0 (- (string-length (editor-pre ed)) 1)) (string-append (string-last (editor-pre ed)) (editor-post ed))))
  

; Editor KeyEvent -> Editor
; moves the cursor one character to the right (if any)
; (define (move-cursor-right ed ke) (make-editor ed ke))

(check-expect (move-cursor-right (make-editor "hello" "world")) (make-editor "hellow" "orld"))

; (define (move-cursor-right ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

;(define (move-cursor-right ed ke)

(define (move-cursor-right ed)
  (make-editor (string-append (editor-pre ed) (string-first (editor-post ed))) (substring (editor-post ed) 1 (string-length (editor-post ed))))) 

; String -> String
; return the first character of the string
; (define (string-first x) "a")

(check-expect (string-first "hello") "h")
   
; (define (string-first x)
;   ( ... x ...))

(define (string-first x)
  (if (> (string-length x) 0) (string-ith x 0) "Empty string")
  )

; String -> String
; return the first character of the strign
; (define (string-last x) "a")

(check-expect (string-last "hello") "o")
   
; (define (string-first x)
;   ( ... x ...))

(define (string-last x)
  (if (> (string-length x) 0) (string-ith x (- (string-length x)1)) "Empty string")
  )
