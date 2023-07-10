(define (image-classify img)
  (cond ((>= (image-height img) (image-width img)) "tall")
        ((= (image-height img) (image-width img))  "square")
        ((<= (image-height img) (image-width img)) "wide")))
   
(image-classify ...)                                           ; image of a rocket was used
                                                               

;; (cond ((>= (image-height ...) (image-width ...)) "tall")
;;       ((= (image-height ...) (image-width ...))  "square")
;;       ((<= (image-height ...) (image-width ...)) "wide"))
;;
;; (cond ((>= 42 (image-width ...))                 "tall")
;;       ((= (image-height ...) (image-width ...))  "square")
;;       ((<= (image-height ...) (image-width ...)) "wide"))
;;
;; (cond ((>= 42 28)                                "tall")
;;       ((= (image-height ...) (image-width ...))  "square")
;;       ((<= (image-height ...) (image-width ...)) "wide"))
;;
;; (#true                                     "tall")
;; ((= (image-height ...) (image-width ...))  "square")
;; ((<= (image-height ...) (image-width ...)) "wide"))
;; "tall"                                                      ; the function returned "tall"


(define (image-classify img)                                   ; the fixed version of the function
  (cond ((> (image-height img) (image-width img))  "tall")     ; >= was changed to >
        ((= (image-height img) (image-width img))  "square")
        ((<= (image-height img) (image-width img)) "wide")))   ; <= was changed to <
