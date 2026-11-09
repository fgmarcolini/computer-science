;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; a)
;; produce a MUPL list with the same elems and order from racket list provided.
;; Racket List -> MUPL List
(define (racketlist->mupllist lst)
  (cond [(null? lst) (aunit)]
        [(list? lst) (apair (car lst) (racketlist->mupllist (cdr lst)))]
        [#t (error "Invalid racket list")]))

;; b)
;; produce a Racket List with the same elems and order from mupl list provided
;; MUPL List -> Racket List
(define (mupllist->racketlist lst)
  (cond [(aunit? lst) null]
        [(apair? lst)
         (cons (apair-e1 lst) (mupllist->racketlist (apair-e2 lst)))]
        [#t (error "Invalid mupl list")]))

;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]

        [(int? e) e]
        
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL if greater than applied to non-number")))]

        [(fun? e) (closure env e)]

        [(call? e)
         (let ([v1 (eval-under-env (call-funexp e) env)]
               [v2 (eval-under-env (call-actual e) env)])
           (if (and (closure? v1))
               (let* ([c-env (closure-env v1)]
                      [c-fun (closure-fun v1)]
                      [fun-name (fun-nameopt c-fun)]
                      [fun-formal (fun-formal c-fun)]
                      [recursive-env (cons (cons fun-name v1) c-env)])
                 (if (string? fun-name) ;; if fun is not anonymous
                     (eval-under-env (fun-body c-fun)
                                     (cons (cons fun-formal v2) recursive-env))
                     (eval-under-env (fun-body c-fun)
                                     (cons (cons fun-formal v2) c-env))))
               (error "MUPL call applied to non-closure")))]
        
        [(mlet? e)
         (let ([v1 (mlet-var e)]
               [v2 (eval-under-env (mlet-e e) env)])
           (if (string? v1)
               (eval-under-env (mlet-body e) (cons (cons v1 v2) env))
               (error "MUPL mlet applied to non MUPL values")))]

        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
           (apair v1 v2))]

        [(fst? e)
         (let ([sub (eval-under-env (fst-e e) env)])
           (if (apair? sub)
               (apair-e1 sub)
               (error "MUPL first element applied to non-pair")))]

        [(snd? e)
         (let ([sub (eval-under-env (snd-e e) env)])
           (if (apair? sub)
               (apair-e2 sub)
               (error "MUPL second element applied to non-pair")))]

        [(aunit? e) e]
        
        [(isaunit? e)
         (let ([v (eval-under-env (isaunit-e e) env)])
           (if (aunit? v)
               (int 1)
               (int 0)))]

        [(closure? e) e]
        
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3
(define (ifaunit e1 e2 e3) (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (let* ([first (car lstlst)]
             [var (car first)]
             [exp (cdr first)]
             [remaining (cdr lstlst)])
        (mlet var exp (mlet* remaining e2)))))

(define (ifeq e1 e2 e3 e4)
  (mlet "_x" e1
        (mlet "_y" e2
              (ifgreater (var "_x") (var "_y")
                         e4
                         (ifgreater (add (int 1) (var "_x")) (var "_y")
                                    e3
                                    e4)))))

;; Problem 4
(define mupl-map
  (fun #f "f"
       (fun "mapper" "lst"
            (ifaunit (var "lst")
                     (aunit)
                     (mlet*
                      (list
                       (cons "first" (fst (var "lst")))
                       (cons "rest" (snd (var "lst")))
                       (cons "first-map" (call (var "f") (var "first")))
                       (cons "rest-map" (call (var "mapper") (var "rest"))))
                      (apair (var "first-map") (var "rest-map")))))))

(define mupl-mapAddN 
  (mlet "map" mupl-map
        (fun #f "i"
             (call mupl-map (fun #f "x" (add (var "i")  (var "x")))))))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
