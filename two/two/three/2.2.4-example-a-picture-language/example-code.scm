#lang racket
(require sicp-pict)
; src: https://docs.racket-lang.org/sicp-manual/SICP_Picture_Language.html


(define e einstein)
(define b (bitmap->painter "buddha.jpg"))

; code modified for racket
(define wave2 (beside b (flip-vert b)))
(define wave4 (below wave2 wave2))
; example usage
; (paint wave4)

; abstracting wave4
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

;(define (corner-split painter n)
;  (if (= n 0)
;      painter
;      (let ((up (up-split painter (- n 1)))
;            (right (right-split painter (- n 1))))
;        (let ((top-left (beside up up))
;              (bottom-right (below right right))
;              (corner (corner-split painter (- n 1))))
;          (beside (below (painter top-left)
;                  (below (bottom-right corner))))))))