#lang racket
(require "extra.rkt")
(require "hw4.rkt")

(require rackunit)

; predefined streams from lecture (also use #4 stream-for-n-steps from HW4 for tests and to see values of streams)
(define ones (lambda () (cons 1 ones)))
(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))
(define a 2)
(define evens
  (letrec ([f (lambda (x)  (cons x (lambda () (f (+ x 2)))))])
    (lambda() (f 2))))
(define ahh ; (a, aa, aaa, etc) 
  (letrec ([f (lambda (s)
                (cons (string-append s "a") (lambda () (f (string-append s "a")))))])
    (lambda() (f ""))))

(define tests
  (test-suite
   "Sample tests for Extra Problems Section 5"

   (check-equal? (palindromic (list)) (list) "palindromic test")
   (check-equal? (palindromic (list 1 2 4 8)) (list 9 6 6 9) "palindromic test")
   (check-equal? (palindromic (list 1)) (list 2) "palindromic test")
   (check-equal? (palindromic (list 1 2)) (list 3 3) "palindromic test")
   (check-equal? (palindromic (list 1 2 3)) (list 4 4 4) "palindromic test")
   (check-equal? (palindromic (make-list 1000 1000)) (make-list 1000 2000) "palidromic test")

   (check-equal? (car (fibonacci)) 1 "Fibonacci test 1")
   (check-equal? (car ((cdr (fibonacci)))) 2 "Fibonacci test 2")
   (check-equal? (car ((cdr ((cdr (fibonacci)))))) 3 "Fibonacci test 3")
   (check-equal? (car ((cdr ((cdr ((cdr (fibonacci)))))))) 5 "Fibonacci test 4")
   (check-equal? (car ((cdr ((cdr ((cdr ((cdr (fibonacci)))))))))) 8 "Fibonacci test 5")
   (check-equal? (car ((cdr((cdr ((cdr ((cdr ((cdr (fibonacci)))))))))))) 13 "Fibonacci test 6")

   (check-equal? (stream-until (lambda(x) (<= x 100)) nats) 100 "Stream until test 1")
   (check-equal? (stream-until (lambda(x) (not (equal? x 32))) nats) 31 "Stream until test 2")
   (check-equal? (stream-until (lambda(x) (< x 100)) evens) 98 "Stream until test 3")
   (check-equal? (stream-until (lambda(x) (not (equal? x 32))) powers-of-two) 16 "Stream until test 4")
   (check-equal?  (stream-until (lambda (x) (< x 10)) fibonacci) 8 "Stream until test 5") 

   (check-equal? (car ((stream-map (lambda(x) (- x)) evens))) -2 "Stream map test 1") ; f makes numbers negative
   (check-equal? (car ((cdr ((stream-map (lambda(x) (- x)) evens))))) -4 "Stream map test 2")
   (check-equal? (car ((cdr ((stream-map (lambda(x) (* x x)) evens))))) 16 "Stream map test 3") ; f squares numbers
   (check-equal? (car ((cdr ((stream-map (lambda(s) (string-append s "b")) ahh))))) "aab" "Stream map test 4")

   (check-equal? (car ((cdr ((stream-zip nats powers-of-two))))) (cons 2 4) "Stream zip test 1")
   (check-equal? (car ((cdr((cdr ((cdr ((cdr ((cdr ((stream-zip ones nats))))))))))))) (cons 1 6) "Stream zip test 2")
   (check-equal? (car ((cdr((cdr ((cdr ((cdr ((cdr ((stream-zip ones powers-of-two))))))))))))) (cons 1 64) "Stream zip test 3")

   (check-equal? (stream-for-n-steps (interleave (list ones nats ahh)) 6) '(1 1 "a" 1 2 "aa") "Interleave test 1")
   (check-equal? (stream-for-n-steps (interleave (list ones nats ahh powers-of-two)) 13) '(1 1 "a" 2 1 2 "aa" 4 1 3 "aaa" 8 1) "Interleave test 2")

   (check-equal? (car ((cdr ((pack 3 nats))))) '(4 5 6) "Pack test 1")
   (check-equal? (stream-for-n-steps (pack 3 nats) 5) '((1 2 3) (4 5 6) (7 8 9) (10 11 12) (13 14 15)) "Pack test 2")
   (check-equal? (stream-for-n-steps (pack 2 nats) 15) '((1 2) (3 4) (5 6) (7 8) (9 10) (11 12) (13 14) (15 16) (17 18) (19 20) (21 22) (23 24) (25 26) (27 28) (29 30)) "Pack test 3")
   (check-equal? (stream-for-n-steps (pack 5 ones) 5) '((1 1 1 1 1) (1 1 1 1 1) (1 1 1 1 1) (1 1 1 1 1) (1 1 1 1 1)) "Pack test 4")

   (check-equal? (perform (+ 1 1) if (= 3 3)) 2 "Perform test 1")
   (check-equal? (perform (+ 1 1) if (= 3 4)) #f "Perform test 2")
   (check-equal? (perform (+ 1 1) unless (= 3 4)) 2 "Perform test 3")
   (check-equal? (perform (+ 1 1) unless (= 3 3)) #t "Perform test 4")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)