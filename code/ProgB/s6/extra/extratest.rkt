#lang racket
(require "extra.rkt")
(require rackunit)

; predefined btrees for testing
(define t1 (btree-node 5 (btree-leaf) (btree-leaf))) ; one node
(define t2
  (btree-node 5 (btree-node 3 (btree-node 1 (btree-node 5 (btree-leaf) (btree-leaf)) (btree-leaf)) (btree-leaf))
              (btree-leaf))) ; 5-3-1-5 all left nodes

;          t3
;
;          7
;         / \
;        3   2
;       / \ / \
;      9  2 1  3
;             / \
;            1   3
;                 \
;                 11
(define t3
  (btree-node 7 (btree-node 3 (btree-node 9 (btree-leaf) (btree-leaf)) (btree-node 2 (btree-leaf) (btree-leaf)))
              (btree-node 2 (btree-node 1 (btree-leaf) (btree-leaf))
                          (btree-node 3 (btree-node 1 (btree-leaf) (btree-leaf)) (btree-node 3 (btree-leaf) (btree-node 11 (btree-leaf) (btree-leaf)))))))

(define tests
  (test-suite
   "Sample tests for Extra Problems Section 6"

   ;tree-height test
   (check-equal? (tree-height t1) 1 "tree-height test 1")
   (check-equal? (tree-height t2) 4 "tree-height test 2")
   (check-equal? (tree-height t3) 5 "tree-height test 3")

   ;sum-tree test
   (check-equal? (sum-tree t1) 5 "sum-tree test 1")
   (check-equal? (sum-tree t2) (+ 5 3 1 5) "sum-tree test 1")
   (check-equal? (sum-tree t3) (+ 7 3 9 2 2 1 3 1 3 11) "sum-tree test 1")

   ;prune-at-v test
   (check-equal? (prune-at-v t1 5) (btree-leaf) "Prune test 1")
   (check-equal? (prune-at-v t1 6) t1 "Prune test 2")
   (check-equal? (prune-at-v t2 5) (btree-leaf) "Prune test 3")
   (check-equal? (prune-at-v t2 1) (btree-node 5 (btree-node 3 (btree-leaf) (btree-leaf)) (btree-leaf)) "Prune test 4")
   (check-equal? (prune-at-v t3 1111) t3 "Prune test 5")
   (check-equal? (prune-at-v t3 3) (btree-node 7 (btree-leaf) (btree-node 2 (btree-node 1 (btree-leaf) (btree-leaf)) (btree-leaf))) "Prune test 6")

   ;well-formed-tree? test
   (check-equal? (well-formed-tree? t1) #t "Well formed test 1")
   (check-equal? (well-formed-tree? t2) #t "Well formed test 2")
   (check-equal? (well-formed-tree? t3) #t "Well formed test 3")
   (check-equal? (well-formed-tree? (btree-node 4 5 (btree-leaf))) #f "Well formed test 4")

   ;;fold-tree test
   (check-equal? (fold-tree (lambda (x y) (+ x y 1)) 7
                            (btree-node 4 (btree-node 5 (btree-leaf) (btree-leaf)) (btree-leaf))) 18 "Tree fold test 1")
   (check-equal? (fold-tree (lambda (x y) (+ x y)) 0 t1) (+ 0 5) "Tree fold test 2")
   (check-equal? (fold-tree (lambda (x y) (* x y)) 1 t2) (* 1 5 3 1 5) "Tree fold test 3")
   (check-equal? (fold-tree (lambda (x y) (+ x y)) 0 t3) (+ 7 3 9 2 2 1 3 1 3 11) "Tree fold test 4")

   ;;fold-tree-curried test
   (check-equal? (((fold-tree-curried (lambda (x y) (+ x y 1))) 7)
                  (btree-node 4 (btree-node 5 (btree-leaf) (btree-leaf)) (btree-leaf))) 18 "Tree fold test 1")
   (check-equal? (((fold-tree-curried (lambda (x y) (+ x y))) 0) t1) (+ 0 5) "Tree fold test 2")
   (check-equal? (((fold-tree-curried (lambda (x y) (* x y))) 1) t2) (* 1 5 3 1 5) "Tree fold test 3")
   (check-equal? (((fold-tree-curried (lambda (x y) (+ x y))) 0) t3) (+ 7 3 9 2 2 1 3 1 3 11) "Tree fold test 4")

   ;;crazy-sum test
   (check-equal? (crazy-sum (list 10 * 6 / 5 - 3)) 9 "Crazy sum test 1")
   (check-equal? (crazy-sum (list 1 1 1 1)) 4 "Crazy sum test 2")
   (check-equal? (crazy-sum (list 5 1 * 6)) 36 "Crazy sum test 3")

   ;;either-fold test
   (check-equal? (either-fold (lambda (x y) (+ x y)) 0 (list 1 2 3 4 5)) (+ 0 1 2 3 4 5) "Either fold test 1")
   (check-equal? (either-fold (lambda (x y) (+ x y)) 0 t3) (+ 7 3 9 2 2 1 3 1 3 11) "Either fold test 2")
   (check-exn exn:fail? (thunk (either-fold (lambda (x y) (+ x y)) 0 10)))

   ;;flatten test
   (check-equal? (flatten (list 5 1 6)) (list 5 1 6) "Flatten test 1")
   (check-equal? (flatten null) null "Flatten test 2")
   (check-equal? (flatten (list 5 (list 1 2 3) 6)) (list 5 1 2 3 6) "Flatten test 3")
   (check-equal? (flatten (flatten (list 1 2 (list (list 3 4) 5 (list (list 6) 7 8)) 9 (list 10)))) (list 1 2 3 4 5 6 7 8 9 10) "Flatten test 4")

   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)