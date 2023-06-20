; ---------- Constant definitions ----------

(define CURSOR (rectangle 1 20 "solid" "red"))
(define SCENE (empty-scene 200 20))
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; ---------- Data definitions ----------

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
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

;; ---------- "Render" function ----------

; Editor -> Image
; develops an image that renders the text within an empty scene
; (define (render ed) img)

(check-expect (render (make-editor "hello" "world"))
              (overlay/align "left" "center"
                      (beside
                       (text "hello" TEXT-SIZE TEXT-COLOR)
                       CURSOR
                       (text "world" TEXT-SIZE TEXT-COLOR))
                      SCENE))

; (define (render ed)
;   (... (editor-pre ed) ... (editor-post ed) ...))

(define (render ed)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                  CURSOR
                  (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
                 SCENE))

;; ---------- "Edit" function ----------

; Editor KeyEvent -> Editor
; -- adds a character,
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

;; ---------- Function definitions (Auxiliarry functions of "Edit" function) ----------

;;; ---------- Auxiliarry function I "add-character" ----------

; Editor KeyEevent -> Editor
; adds a single-character to the end of the pre field of ed
; (define (add-character ed ke) (make-editor s t))

(check-expect (add-character (make-editor "hello" "world") "a") (make-editor "helloa" "world"))

; (define (add-character ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (add-character ed ke)
  (cond
    [(<(image-width(text (string-append (editor-pre ed)(editor-post ed)) TEXT-SIZE TEXT-COLOR))190)       ; updated (a cond statement added)
  (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
    ))

;;; ---------- Auxiliarry function II "delete-character" ----------

; Editor -> Editor
; deletes the character immediatelly to the left  of the cursor
; (define (delete-character ed) (make-editor s t))

(check-expect (delete-character (make-editor "hello" "world")) (make-editor "hell" "world"))

; (define (delete-character ed)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (delete-character ed)
  (make-editor (substring (editor-pre ed) 0 (-(string-length (editor-pre ed)) 1)) (editor-post ed)))

;;; ---------- Auxiliarry function III "move-cursor-left" ----------

; Editor KeyEvent -> Editor
; moves the cursor one character to the left (if any)
; (define (move-cursor-left ed ke) (make-editor ed ke))

(check-expect (move-cursor-left (make-editor "hello" "world")) (make-editor "hell" "oworld"))

; (define (move-cursor-left ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (move-cursor-left ed)
  (make-editor (substring (editor-pre ed) 0 (- (string-length (editor-pre ed)) 1)) (string-append (string-last (editor-pre ed)) (editor-post ed))))
  
;;; ---------- Auxiliarry function IV "move-cursor-right" ----------

; Editor KeyEvent -> Editor
; moves the cursor one character to the right (if any)
; (define (move-cursor-right ed ke) (make-editor ed ke))

(check-expect (move-cursor-right (make-editor "hello" "world")) (make-editor "hellow" "orld"))

; (define (move-cursor-right ed ke)
;   (... (editor-pre ed) ... (editor-post ed)
;        ... ke ... ))

(define (move-cursor-right ed)
  (make-editor (string-append (editor-pre ed) (string-first (editor-post ed))) (substring (editor-post ed) 1 (string-length (editor-post ed))))) 
  
;;; ---------- Auxiliarry function V "string-first" ----------

; String -> String
; returns the first character of the string
; (define (string-first x) "a")

(check-expect (string-first "hello") "h")
   
; (define (string-first x)
;   ( ... x ...))

(define (string-first x)
  (if (> (string-length x) 0) (string-ith x 0) "Empty string")
  )
  
;;; ---------- Auxiliarry function VI "string-last" ----------

; String -> String
; returns    the first character of the strign
; (define (string-last x) "a")

(check-expect (string-last "hello") "o")
   
; (define (string-first x)
;   ( ... x ...))

(define (string-last x)
  (if (> (string-length x) 0) (string-ith x (- (string-length x)1)) "Empty string")
  )

; ---------- Application ----------

;; ---------- "Run" function ----------

; Editor -> Editor
; launches an interactive editor
(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]
    ))
