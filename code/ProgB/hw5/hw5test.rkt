#lang racket
;; Programming Languages Homework 5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and, if necessary, change the filename
(require "hw5.rkt")

(require rackunit)

(define env1 (cons (cons "x" (int 10)) (cons (cons "y" (int 20)) null)))

;; CALL TESTS
; Test 1: Calling a function stored in a closure
(define closure1 (closure env1 (fun "add" "z" (add (var "z") (var "x")))))
(define call1 (call closure1 (int 5)))
; Expected result: (int 15) (z is 5, x is 10)

; Test 2: Calling an anonymous function stored in a closure
(define closure2 (closure env1 (fun #f "z" (add (var "z") (var "y")))))
(define call2 (call closure2 (int 30)))
; Expected result: (int 50) (z is 30, y is 20)

; Test 3: Calling a closure with a non-closure value
(define non_closure (int 42))
(define call3 (call non_closure (int 5)))
; Expected result: Error "MUPL call applied to non-closure"

; Test 4: Calling a closure with an invalid function
(define invalid_closure (closure env1 (int 42)))
(define call4 (call invalid_closure (int 5)))
; Expected result: Error "MUPL call applied to non-closure"

; Test 5: Factorial function, sum of 0..n numbers
(define closure3
  (closure
   '()
   (fun "sum-of-n" "n"
        (ifgreater (var "n") (int 1)
                   (add (var "n") (call (var "sum-of-n") (add (var "n") (int -1))))
                   (int 1)))))
(define call5 (call closure3 (int 6)))
; Expected result: (int 21) (6+5+4+3+2+1)


(define tests
  (test-suite
   "Sample tests for Assignment 5"
   
   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist (list)) (aunit) "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (int 3) (int 4))) (apair (int 3) (apair (int 4) (aunit))) "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (var "x") (int 5))) (apair (var "x") (apair (int 5) (aunit))) "racketlist->mupllist test")
   
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (aunit)) (list) "mupllist->racketlist test")
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit)))) (list (int 3) (int 4)) "mupllist->racketlist test")
   (check-equal? (mupllist->racketlist (apair (var "x") (apair (int 5) (aunit))))  (list (var "x") (int 5)) "mupllist->racketlist test")

   ;; tests if ifgreater returns (int 2)
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 4) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 5) (int 4) (int 3) (int 2))) (int 3) "ifgreater test")
   (check-exn exn:fail? (thunk (eval-exp (ifgreater (int 5) "whatever" (int 3) (int 2)))))
   
   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x")))) (int 6) "mlet test")
   (check-equal? (eval-exp (mlet "x" (int 4) (add (int 5) (var "x")))) (int 9) "mlet test")
   (check-equal? (eval-exp (mlet "x" (int 4) (add (int 5) (mlet "x" (int 10) (add (int 1) (var "x")))))) (int 16) "mlet test")
   
   ;; call test
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 10)))) (int 1))) (int 11) "call test")
   (check-equal? (eval-exp (call (closure '() (fun "abc" "y" (var "y"))) (int 1))) (int 1) "call test")
   (check-equal? (eval-exp (call (closure '() (fun "f" "y" (ifgreater (var "y") (int 11) (int 0) (int 1)))) (int 2))) (int 1) "call test")
   (check-equal? (eval-exp call1) (int 15) "call test")
   (check-equal? (eval-exp call2) (int 50) "call test")
   (check-exn exn:fail? (thunk (eval-exp call3)))
   (check-exn exn:fail? (thunk (eval-exp call4)))
   (check-equal? (eval-exp call5) (int 21) "call test")
   
   ;;apair test
   (check-equal? (eval-exp (apair (add (int 1) (int 2)) (add (int 5) (int 1)))) (apair (int 3) (int 6)) "apair test") 
   
   ;;fst test
   (check-equal? (eval-exp (fst (apair (int 1) (int 2)))) (int 1) "fst test")
   (check-exn exn:fail? (thunk (eval-exp (fst "whatever"))))
   ;(check-equal? (eval-exp (fst (apair 1 2))) 1 "fst test")
   
   ;;snd test
   (check-equal? (eval-exp (snd (apair (int 1) (int 2)))) (int 2) "snd test")
   (check-exn exn:fail? (thunk (eval-exp (snd "whatever"))))
   ;;(check-equal? (eval-exp (snd (apair 1 2))) 2 "fst test")
   
   ;; isaunit test
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit))))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (apair (int 1) (apair (int 2) (aunit))))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (aunit))) (int 1) "isaunit test")
   
   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3))) (int 3) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (aunit) (int 2) (int 3))) (int 2) "ifaunit test")
      
   ; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))) (var "x"))) (int 10) "mlet* test")
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10)) (cons "y" (add (var "x") (int 11)))) (var "x"))) (int 10) "mlet* test")
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10)) (cons "y" (add (var "x") (int 11)))) (var "y"))) (int 21) "mlet* test")
      
   ; ifeq test
   (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4))) (int 4) "ifeq test")
   (check-equal? (eval-exp (ifeq (int 1) (int 1) (int 3) (int 4))) (int 3) "ifeq test")
   (check-equal? (eval-exp (ifeq (int 2) (int 1) (int 3) (int 4))) (int 4) "ifeq test")
   
      
   ;; mupl-map test
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit)))) 
                 (apair (int 8) (aunit)) "mupl-map test")
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 2)))) 
                                 (apair (int 1) (apair (int 2) (aunit)))))
                 (apair (int 3) (apair (int 4) (aunit))) "mupl-map test 1")
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (ifgreater (var "x") (int 0) (int 1) (int 0)))) 
                                 (apair (int 1) (apair (int 0) (aunit)))))
                 (apair (int 1) (apair (int 0) (aunit))) "mupl-map test")
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int -1)))) 
                                 (apair (int 5) (apair (int 3) (aunit)))))
                 (apair (int 4) (apair (int 2) (aunit))) "mupl-map test")
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (var "x")))) 
                                 (apair (int 2) (apair (int 4) (aunit)))))
                 (apair (int 4) (apair (int 8) (aunit))) "mupl-map test")

   ;; problems 1, 2, and 4 combined test
   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-mapAddN (int 7))
                                  (racketlist->mupllist 
                                   (list (int 3) (int 4) (int 9)))))) (list (int 10) (int 11) (int 16)) "combined test")
      (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-mapAddN (int 5))
                                  (racketlist->mupllist (list)))))
                 (list) "mupl-mapAddN test")
   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-mapAddN (int 5))
                                  (racketlist->mupllist (list (int 2) (int 7) (int 10))))))
                 (list (int 7) (int 12) (int 15)) "combined test")
   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-mapAddN (int 0))
                                  (racketlist->mupllist (list (int 1) (int 5) (int 8))))))
                 (list (int 1) (int 5) (int 8)) "combined test")
   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-mapAddN (int -3))
                                  (racketlist->mupllist (list (int 6) (int 2) (int 1))))))
                 (list (int 3) (int -1) (int -2)) "combined test")
   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-mapAddN (int 10))
                                  (racketlist->mupllist (list (int 0) (int -5) (int 7))))))
                 (list (int 10) (int 5) (int 17)) "combined test")

   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
