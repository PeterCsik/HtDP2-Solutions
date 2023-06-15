(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-apend s t) with
; the cursor displayed between s and t

(define ed1 (make-editor "hello" "world"))
(define ed2 (make-editor "Silicon" "Valley"))
(define ed3 (make-editor "Knight" "Rider"))


(define CURSOR (rectangle 1 20 "solid" "red"))
(define SCENE (empty-scene 200 20))
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")


; Editor -> Image
; renders the text within an empty space of 200 x 20 pixels
; (define (render editor) img)

(check-expect (render (make-editor "hello" "world"))
              (overlay/align "left" "center"
                      (beside
                       (text "hello" TEXT-SIZE TEXT-COLOR)
                       CURSOR
                       (text "world" TEXT-SIZE TEXT-COLOR))
                      SCENE))

;(define (render ed)
;  (... (editor-pre ed) ... (editor-post ed) ...))

(define (render ed)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                  CURSOR
                  (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
                 SCENE))
