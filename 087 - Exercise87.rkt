; ---------- Constant definitions ----------

(define CURSOR (rectangle 1 20 "solid" "red"))
(define SCENE (empty-scene 200 20))
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; ---------- Data definitions ----------

(define-struct editor [text cursor])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor t n) describes an editor
; whose first field contains the entire text entered, and
; the other the number of characters between the first character
; (counting from the left) and the cursor

(define ed1 (make-editor "hello world" 2))
(define ed2 (make-editor "Silicon Valley" 0))
(define ed3 (make-editor "Knight" 6))

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

(check-expect (render (make-editor "hello world" 2))
              (overlay/align "left" "center"
                      (beside
                       (text "he" TEXT-SIZE TEXT-COLOR)
                       CURSOR
                       (text "llo world" TEXT-SIZE TEXT-COLOR))
                      SCENE))

; (define (render ed)
;   (... (editor-text ed) ... (editor-cursor ed) ...))

(define (render ed)
  (overlay/align "left" "center"
                 (beside
                  (text (substring1 ed) TEXT-SIZE TEXT-COLOR)
                  CURSOR
                  (text (substring2 ed) TEXT-SIZE TEXT-COLOR))
                 SCENE))


(define (substring1 ed)
  (substring (editor-text ed) 0 (editor-cursor ed)))

(define (substring2 ed)
  (substring (editor-text ed)(editor-cursor ed) (string-length (editor-text ed))))

;; ---------- "Edit" function ----------

; Editor KeyEvent -> Editor
; -- adds a character,
; -- deletes a character,
; -- moves the cursor to the left
; -- moves the cursor to the right
; (define (edit ed ke) (make-editor t n))

; (define (edit ed ke)
;   (... (editor-text ed) ... (editor-cursor ed)
;        ... ke ... ))

(check-expect (edit (make-editor "hello world" 2) "\b") (make-editor "hllo world" 1))
(check-expect (edit (make-editor "hello world" 2) "a") (make-editor "heallo world" 3))
(check-expect (move-cursor-left (make-editor "hello world" 2) "left") (make-editor "hello world" 1))
(check-expect (move-cursor-right (make-editor "hello world" 2) "right") (make-editor "hello world" 3))

(define (edit ed ke)
  (cond
    [(key=? ke "\b") (delete-character ed ke)]
    [(= (string-length ke) 1) (add-character ed ke)]
    [(key=? ke "left") (move-cursor-left ed ke)]
    [(key=? ke "right") (move-cursor-right ed ke)]
        ))

;; ---------- Function definitions (Auxiliarry functions of "Edit" function) ----------

;;; ---------- Auxiliarry function I "add-character" ----------

; Editor KeyEvent -> Editor
; adds a single-character to the end of the pre field of ed
; (define (add-character ed ke) (make-editor t n))

(check-expect (add-character (make-editor "hello world" 2) "a") (make-editor "heallo world" 3))

;(define (add-character ed ke)
;  (... (editor-text ed) ... (editor-cursor ed)
;       ... ke ... ))

(define (add-character ed ke)
  (cond
    [(>(image-width(text (editor-text ed) TEXT-SIZE TEXT-COLOR))190)(make-editor (editor-text ed)(editor-cursor ed))]
    [else (make-editor (string-append (substring1 ed) ke (substring2 ed)) (+ (editor-cursor ed) 1))]
    ))


;;; ---------- Auxiliarry function II "delete-character" ----------

; Editor KeyEvent -> Editor
; ; deletes the character immediatelly to the left  of the cursor
; (define (delete-character ed ke) (make-editor t n))

(check-expect (delete-character (make-editor "hello world" 2) "\b") (make-editor "hllo world" 1))

;(define (delete-character ed ke)
;  (... (editor-text ed) ... (editor-cursor ed)
;       ... ke ... ))

(define (delete-character ed ke)
  (cond
    [(= (editor-cursor ed) 0) (make-editor (editor-text ed) 0)]
    [else (make-editor (string-append (substring(substring1 ed) 0 (- (editor-cursor ed) 1)) (substring2 ed)) (- (editor-cursor ed) 1))]
    ))


;;; ---------- Auxiliarry function III "move-cursor-left" ----------

; Editor KeyEvent -> Editor
; moves the cursor one character to the left (if any)
; (define (move-cursor-left ed ke) (make-editor t n))

(check-expect (move-cursor-left (make-editor "hello world" 2) "left")
              (make-editor "hello world" (- 2 1)))

;(define (move-cursor-left ed ke)
;  (... (editor-text ed) ... (editor-cursor ed)
;       ... ke ... ))

(define (move-cursor-left ed ke)
  (cond
    [(= (editor-cursor ed) 0) (make-editor (editor-text ed) 0)]
    [ else (make-editor (editor-text ed) (- (editor-cursor ed) 1))]
    ))

;;; ---------- Auxiliarry function IV "move-cursor-right" ----------

; Editor KeyEvent -> Editor
; moves the cursor one character to the right (if any)

; (define (move-cursor-right ed ke) (make-editor t n))

(check-expect (move-cursor-right (make-editor "hello world" 2) "left")
              (make-editor "hello world" (+ 2 1)))

;(define (move-cursor-right ed ke)
;  (... (editor-text ed) ... (editor-cursor ed)
;       ... ke ... ))

(define (move-cursor-right ed ke)
  (cond
    [(= (editor-cursor ed) (string-length (editor-text ed))) (make-editor (editor-text ed) (editor-cursor ed))]
    [else (make-editor (editor-text ed) (+ (editor-cursor ed) 1))]
    ))


; ---------- Application ----------

;; ---------- "Run" function ----------

; Editor -> Editor
; launches an interactive editor
(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]
    ))
