(* 1 *)
(* composes 2 functions with optional values. If one returns NONE, then produce
* NONE*)
(* ('b -> 'c option) -> ('a -> 'b option) -> 'a -> 'c option *)
fun compose_opt f g x =
  case g x of
       NONE => NONE
     | SOME y => f y

(* 2 *)
(* applies f to x until p x produce false *)
(* ('a -> 'a) -> ('a -> bool) -> 'a -> 'a *)
fun do_until f p x = 
  if not (p x)
  then x 
  else do_until f p (f x)

(* 3 *)
(* produce factorial of x *)
(* int -> int *)
fun fact_do_until n = 
  #1 (do_until (fn (acc, x) => (acc*x, x-1)) (fn (_, x) => x<>0) (1, n))

(* 4 *)
(* applies f to x until f x = x *)
(* (''a -> ''a) -> ''a -> ''a *)
fun fixed_point f =
  do_until f (fn x => f x <> x)
  
(* 5 *)
(* applies f to a pair p, produces a pair *)
(* ('a -> 'b) -> 'a * 'a -> 'b * 'b *)
fun map2 f (x, y) = 
  (f x, f y)

(* 6 *)
(* applies f to each element of the list produced by g, and concatenates the results *)
(* ('b -> 'c list) -> ('a -> b' list) -> 'a -> c' list *)
fun app_all f g = 
 (foldr (op @) []) o (map f) o g

(* 7 *)
(* from right to left fold the function f over all the elements of a list,
* using the x as initial value *)
(* ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun foldr f x = 
  (foldl f x) o rev
  
(* 8 *) 
(* partition list lst into two based on a given condition c *) 
(* ('a -> bool) -> 'a list -> 'a list -> 'a list * 'a list *) 
(* !!! *)
fun partition c lst = ([], []) 
