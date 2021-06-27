; Exercise 1.46.  Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as iterative improvement. Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess. 

; Write a procedure iterative-improve that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess. Iterative-improve should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough. Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 1.3.3 in terms of iterative-improve.
(define (iterative-improve good-enough? improve)
	(lambda (guess)
		(if (good-enough? guess)
			guess
			((iterative-improve good-enough? improve) (improve guess)))))

; quick test example
(define close-enough 0.1)
(define ref-val 10)
(define (good-enough-test guess)
	(< (abs (- guess ref-val)) close-enough))

(define (improve-test guess)
	(+ guess 1))

; ((iterative-improve good-enough-test improve-test) 1.001) -> 10.001

; re-defining fixed-point (1.3.3) in terms of iterative-improve
(define tolerance 0.00001)
(define (close-enough? v1 v2 tolerance)
	(< (abs (- v1 v2)) tolerance))

(define (fixed-point f first-guess)
	((iterative-improve (lambda (x) (close-enough? x (f x) tolerance))
											(lambda (guess) (f guess)))
											first-guess))

; testing fixed-point
; (fixed-point cos 1.0) -> .7390822985224023

; re-defining sqrt (1.1.7) in terms of iterative-improve
(define (average a b) (/ (+ a b) 2.0))
(define (sqrt x)
	((iterative-improve (lambda (val) (close-enough? (square val) x tolerance))
											(lambda (guess) (average guess (/ x guess))))
											1.0))

; testing sqrt
; 1 ]=> (sqrt 9)
;Value: 3.000000001396984
; minor differences due to the fact that we changed the tolerance from 1.1.7