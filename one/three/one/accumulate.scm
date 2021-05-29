; a. Show that sum and product (exercise 1.31) are both special cases of a still more general notion called accumulate that combines a collection of terms, using some general accumulation function:

; (accumulate combiner null-value term a next b)

; Accumulate takes as arguments the same term and range specifications as sum and product, together with a combiner procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a null-value that specifies what base value to use when the terms run out. Write accumulate and show how sum and product can both be defined as simple calls to accumulate.

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))
(define (product term a next b)
  (accumulate * 1 term a next b))

; iterative
(define (iaccumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (isum term a next b)
  (iaccumulate + 0 term a next b))
(define (iproduct term a next b)
  (iaccumulate * 1 term a next b))

; testing
(define (identity i) i)
(define (++ i) (+ i 1))
(define (cube x) (* x x x))

; recursive
(define (! n) (product identity 1 ++ n))
(define (sum-cubes n) (sum cube 1 ++ n))

; 1 ]=> (! 5)

; ;Value: 120

; 1 ]=> (sum-cubes 10)

; ;Value: 3025

; iterative
(define (i! n) (iproduct identity 1 ++ n))
(define (isum-cubes n) (isum cube 1 ++ n))

; 1 ]=> (i! 5)

; ;Value: 120

; 1 ]=> (isum-cubes 10)

; ;Value: 3025