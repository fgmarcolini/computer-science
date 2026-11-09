
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; produces a list of sequence between low and high with stride steps
;; Number Number Number -> Number List
;; ASSUME: stride >= 0
(define (sequence low high stride)
  (letrec ([loop
             (lambda (l) 
               (if (> l high)
                 null
                 (cons l (loop (+ l stride)))))])
    (loop low)))

;; produces a list of str with suffix applied to each element of original list lst
;; (String List) String -> (String List)
(define string-append-map
  (lambda (lst suffix)
    (map (lambda (str) (string-append str suffix)) lst)))

;; produce the ith element of the list in which i is the remainder of n divided by length lst
;; if n<0 or lst is the empty list produce an error
;; (Integer List) Integer -> Integer
(define list-nth-mod
  (lambda (lst n)
    (cond [(< n 0) (error "list-nth-mod: negative number")]
          [(null? lst) (error "list-nth-mod: empty list")]
          [#t (car (list-tail lst (remainder n (length lst))))])))

;; produce a list holding the first n values produced by stream s in order
;; Stream Integer -> Integer List
(define stream-for-n-steps
  (lambda (s n)
    (if (= n 0)
      null
      (let ([actual (s)])
        (cons (car actual) (stream-for-n-steps (cdr actual) (- n 1)))))))

;; produce a stream of natural numbers, except num divisible by 5 are negated
;; Thunk -> (cons Integer Stream)
(define funny-number-stream
  (letrec ([f (lambda (x)
                (if (= (remainder x 5) 0)
                    (cons (- x) (lambda () (f (+ x 1))))
                    (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

;; produce a stream with elements "dan.jpg" and "dog.jpg" alternate between each other
;; Thunk -> (cons String Stream)
;; ASSUME: starts stream with "dan.jpg"
(define dan-then-dog
  (letrec ([f (lambda () (cons "dan.jpg" g))]
           [g (lambda () (cons "dog.jpg" f))])
    f))

;; produce a stream that concats 0 to each value of given stream s
;; Stream -> Stream
(define (stream-add-zero s)
  (lambda ()
    (let ([s-next (s)])
      (cons (cons 0 (car s-next)) (stream-add-zero (cdr s-next))))))

;; produce a stream with pairs values where 1st part is from xs and 2nd part is from ys
;; (Integer List) (Integer List) -> Stream
;; ASSUME: xs and ys are both non-empty lists
(define cycle-lists
  (lambda (xs ys)
    (letrec ([f (lambda (n)
                  (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                        (lambda () (f (+ n 1)))))])
      (lambda () (f 0)))))

;; produce pair of 1st elem. of v whose car is equal to x, otherwise if not found produce #f
;; (GenericA) (Vector) -> (cons (GenericA) GenericB)
(define vector-assoc
  (lambda (x v)
    (letrec ([f (lambda (n)
                  (cond [(>= n (vector-length v)) #f]
                        [(and (pair? (vector-ref v n))
                              (equal? (car (vector-ref v n)) x))
                         (vector-ref v n)]
                        [#t (f (+ n 1))]))])
      (f 0))))

;; produce a function that takes an arg v and returns the same thing that
;; (assoc v xs) would return but with a element cache for improve performance.
;; ASSUME: n args is positive
(define (cached-assoc xs n)
  (let ([cache (vector n #f)]
        [next-index 0])
    (lambda (v)  
      (or (vector-assoc v cache) ;; is already v in the cache?
          (let ([pair (assoc v xs)])
            (and pair ;; v is not in the cache and pair is found
                 (begin (vector-set! cache next-index pair) ;; adds pair to cache
                        (set! next-index 
                          (if (= (+ next-index 1) n) 0 (+ next-index 1))) ;; set next-index to +1 or 0 if reach n
                        pair))))))) ;; returns pair
      

;; challenge problem
;; macro while-less
;; ASSUME: e1 and e2 produce numbers
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([e3 e1])
       (letrec ([loop (lambda ()
                        (let ([e4 e2])
                          (if (< e4 e3)
                            (loop)
                            #t)))])
         (loop)))]))
