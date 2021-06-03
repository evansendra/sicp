(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; (fixed-point cos 1.0)
; .7390822985224023

; (fixed-point (lambda (y) (+ (sin y) (cos y)))
;              1.0)
; 1.2587315962971173

(define (sqrt x) 
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

; In fact, if we unravel the definitions, we can see that the sequence of approximations to the square root generated here is precisely the same as the one generated by our original square-root procedure of section 1.1.7!

