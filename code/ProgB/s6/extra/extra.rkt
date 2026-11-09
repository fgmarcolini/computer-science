#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

(struct btree-leaf () #:transparent)
(struct btree-node (value left right) #:transparent)

;; BTree-Node|BTree-Leaf -> Int
;; produces the height of a btree, meaning the longest path of a leaf.
;;(define (tree-height bt) 0) ;stub
(define (tree-height bt)
  (if (btree-leaf? bt)
      0
      (+ 1 (max (tree-height (btree-node-left bt))
                (tree-height (btree-node-right bt))))))

;; BTree-Node|BTree-Leaf -> Number
;; produces the sum of all values in a btree
;; ASSUME: values in btree are numbers
;;(define (sum-tree bt) 0) ;stub
(define (sum-tree bt)
  (if (btree-leaf? bt)
      0
      (+ (btree-node-value bt)
         (sum-tree (btree-node-left bt))
         (sum-tree (btree-node-right bt)))))

;; BTree-Node|BTree-Leaf -> BTree-Node|BTree-Leaf
;; produces a btree same as given but every tree
;; that the value equals v is replaced by a leaf
;;(define (prune-at-v bt v) bt) ;stub
(define (prune-at-v bt v)
  (if (or (btree-leaf? bt)
          (equal? (btree-node-value bt) v))
      (btree-leaf)
      (btree-node (btree-node-value bt)
                  (prune-at-v (btree-node-left bt) v)
                  (prune-at-v (btree-node-right bt) v))))

;; A -> Boolean
;; produces #t if v is a btree (btree-node or btree-leaf)
;;(define (well-formed-tree? v) #f) ;stub
(define (well-formed-tree? v)
  (or (btree-leaf? v)
      (and (btree-node? v)
           (well-formed-tree? (btree-node-left v))
           (well-formed-tree? (btree-node-right v)))))

;; (A A -> B) B BTree-Node|BTree-Leaf -> B
;; implements fold over a btree, applying f to all the values
;(define (fold-tree f ac bt) ac) ;stub
(define (fold-tree f acc bt)
  (if (btree-leaf? bt)
      acc
      (let* ([fold-left (fold-tree f (f acc (btree-node-value bt)) (btree-node-left bt))]
             [fold-right (fold-tree f fold-left (btree-node-right bt))])
        fold-right)))

;; other solution
(define (fold-tree2 f acc bt)
  (if (btree-leaf? bt)
      acc
      (f (fold-tree f (btree-node-value bt) (btree-node-left bt))
         (fold-tree f acc (btree-node-right bt)))))

;; 1st solution as a curried function
(define (fold-tree-curried f)
  (lambda (acc)
    (lambda (bt)
      (if (btree-leaf? bt)
          acc
          (let* ([fold-left (((fold-tree-curried f) (f acc (btree-node-value bt))) (btree-node-left bt))]
                 [fold-right (((fold-tree-curried f) fold-left) (btree-node-right bt))])
            fold-right)))))

;; (listOf Number|(Number Number -> Number)) -> Number
;; produce sum (+) of all numbers in list, except:
;; if the elem. is a function then the operation is not more + and it's now that function
;; ASSUME: 1st elem. is a number
;;(define (crazy-sum lon) 0) ;stub
(define (crazy-sum lon)
  (letrec ([f (lambda (acc lon op)
                (cond [(null? lon) acc]
                      [(number? (car lon))
                       (f (op acc (car lon)) (cdr lon) op)]
                      [(procedure? (car lon))
                       (f acc (cdr lon) (car lon))]
                      [#t (error "Element isn't a number or a procedure")]))])
    (f (car lon) (cdr lon) +)))

;; (A A -> B) B (listOf A)|(BTree-Node|BTree-Leaf) -> B
;; fold a list or a btree, depends on arg. If none, gives an error
;;(define (either-fold f acc lst-or-btree) acc) ;stub
(define (either-fold f acc lst-or-btree)
  (cond [(list? lst-or-btree) (foldr f acc lst-or-btree)]
        [(well-formed-tree? lst-or-btree) (fold-tree f acc lst-or-btree)]
        [else (error "3rd arg isn't a list or a btree")]))

;; Z means can be any type (even not the same type between lists)
;; (listOf Z|(listOf Z|(listOf Z|...)) -> (listOf Z)
;; produce a list with only indivisible elems., merging all the nested lists if needed
;(define (flatten lst) lst) ;stub
(define (flatten lst)
  (cond [(null? lst) null]
        [(list? (car lst))
         (append (flatten (car lst)) (flatten (cdr lst)))]
        [else
         (cons (car lst) (flatten (cdr lst)))]))

