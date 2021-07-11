; After considerable work, Alyssa P. Hacker delivers her finished system. Several years later, after she has forgotten all about it, she gets a frenzied call from an irate user, Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel resistors can be written in two algebraically equivalent ways:

; R1R2 / (R1 + R2)

; 1 / ((1/R1)+(1/R2))

; He has written the following two programs, each of which computes the parallel-resistors formula differently:

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1))) 
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

; Lem complains that Alyssa's program gives different answers for the two ways of computing. This is a serious complaint.

; Exercise 2.14.  Demonstrate that Lem is right. Investigate the behavior of the system on a variety of arithmetic expressions. Make some intervals A and B, and use them in computing the expressions A/A and A/B. You will get the most insight by using intervals whose width is a small percentage of the center value. Examine the results of the computation in center-percent form (see exercise 2.12).

; to demonstrate Lem is right, we can show that (not (= (par1 a b) (par2 a b))), for example
; print-interval shortened to pi
(define (pi i)
  (display (center i))
  (display " ± ")
  (display (percent i)))

; 1 ]=> (define r1 (make-center-percent 3 0.1))
;Value: r1
; 1 ]=> (define r2 (make-center-percent 5 0.1))
;Value: r2
; 1 ]=> (define res1 (par1 r1 r2))
;Value: (1.8693824925074929 . 1.8806325075075077)
; 1 ]=> (define res2 (par2 r1 r2))
;Value: (1.8731250000000002 . 1.8768750000000003)

; 1 ]=> (pi res1)
; 1.8750075000075004 ± .29999920000238783
; 1 ]=> (pi res2)
; 1.8750000000000002 ± .10000000000000378

; another example which shows that Lem is right is as follows
; obviously a*(a/a) simplifies to a so the first expression is equivalent to a/b

; 1 ]=> (pi (div-interval (mul-interval a (div-interval a a)) b))
; 2.0016006652667313 ± 3.498850422344508

; 1 ]=> (pi (div-interval a b))
; 2.001000400160064 ± 2.4997500249974944

; We can see that while the center values are relatively similar, the percent values differ quite a lot in each example above
; This is due to the fact that when we compute something like line 46, we are not taking the abstract value a divided by a, multiplying by a and receiving the abstract value a.  Rather, we are taking a's computer-represented value (9.95 . 10.05), multiplying a's upper and lower bounds by the reciprocal of themselves, which tries to find a minimum and maximum based on the cross-computation of the upper and lower bounds of a and a.  So instead of getting the 1 interval (1 . 1), we get (9.95*(1/10.05), 10.05*(1/9.95)).

