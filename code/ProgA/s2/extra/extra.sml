type student_id = int
type grade = int (* must be in 0 to 100 range *)
type final_grade = { id : student_id, grade : grade option }
datatype pass_fail = pass | fail

datatype 'a tree = leaf 
                 | node of { value : 'a, left : 'a tree, right : 'a tree }
datatype flag = leave_me_alone | prune_me

datatype nat = ZERO | SUCC of nat
exception Negative

datatype intSet = Elems of int list (*list of integers, possibly with duplicates to be ignored*)
                | Range of { from : int, to : int }  (* integers from one number
                to another *)
                | Union of intSet * intSet (* union of the two sets *)
                | Intersection of intSet * intSet (* intersection of the two
                sets *)

(* FUNCTIONS *)

(* 1 *)
(* {grade : int option, id : 'a} -> pass_fail *)
(* produces pass if the grade contains SOME i for an i >= 75. otherwise fail *)
fun pass_or_fail {grade=g, id=_} =
  case g of
       NONE => fail
     | SOME i => if i >= 75 then pass else fail

(* 2 *)
(* {grade : int option, id : 'a} -> bool *)
(* produce true if the grade field pass the test *)
fun has_passed fg = 
  case pass_or_fail fg of
       fail => false
     | pass => true

(* 3 *)
(* final_grade list -> int *)
(* produces total of elements have passing in list *)
fun number_passed lst =
let
  fun helper ([], acc) = acc
    | helper (x::xs, acc) =
    case has_passed x of
         false => helper (xs, acc)
       | true => helper (xs, 1 + acc)
in
  helper (lst, 0)
end 

(* 4 *)
(* (pass fail * final grade) list -> int *)
(* produce how many list elements are mislabeled *)
fun number_misgraded xs = 
let
  fun helper ([], acc) = acc
    | helper (xs::xs', acc) =
    case xs of
         (pass, x) =>
         if not(has_passed x) 
         then helper(xs', acc + 1) 
         else helper(xs', acc) 
       | (fail, x) =>
       if has_passed x 
       then helper(xs', acc + 1) 
       else helper(xs', acc) 
in
  helper (xs, 0)
end
  
(* 5 *)
(* 'a tree -> int *)
(* produce the height of a tree *)
fun tree_height t = 
  case t of 
       leaf => 0
     | node {value=_, left=l, right=r} => 
    let 
      val height_l = 1 + tree_height l
      val height_r = 1 + tree_height r
    in
      if height_l >= height_r then height_l else height_r
    end

(* 6 *) 
(* int tree -> int *) 
(* produce the sum of all values in a int tree *)
fun sum_tree(leaf) = 0
  | sum_tree(node {value=v, left=l, right=r}) = v + sum_tree l + sum_tree r

(* 7 *)
(* flag tree -> flag tree *)
(* produce a tree with the nodes in lst containing prune_me replaced with a
* leaf *)
fun gardener tree =
  case tree of
       node {value=leave_me_alone, right=r, left=l} => 
       node {value=leave_me_alone, right=gardener r, left=gardener l}
     | _ => leaf

(* 8 *)
(* 'a list -> 'a *)
(* returns the last element of xs. if list is empty raises exn Empty *)
fun last xs =
  case xs of 
       [] => raise Empty
     | x::[] => x
     | x::xs => last xs

(* 'a list * int -> 'a list *)
(* produce the first i elements of xs *)
(* ASSUME: 0 <= i <= size xs *)
fun take (_, 0) = []
  | take (hd::tl, i) = hd::take(tl, i-1)

(* 'a list * int -> 'a list *)
(* produce what is left after dropping the first i elements of xs *)
fun drop (xs, 0) = xs
  | drop (_::xs, i) = drop(xs, i-1)
  | drop ([], _) = []

(* a' list list -> 'a list *)
(* produce a list with the concatenation of all lists in order *)
fun concat xs =
  case xs of
       [] => []
     | (y::[])::xs => y::concat(xs)
     | (y::ys)::xs => y::concat(ys::xs)

fun concat2 xs = 
  case xs of
       [] => []
     | x::xs => x @ concat2(xs)

(* a' option * a' -> a' *)
(* produces v if opt is SOME(v); otherwise returns a *)
fun getOpt (opt, a) = 
  case opt of
       NONE => a
     | SOME v => v

(* a' option option -> a' option *)
(* maps NONE to NONE and SOME(v) to v *)
fun join opt = 
  case opt of
       NONE => NONE
     | SOME x =>  x

(* 9 *)
(* nat -> bool *)
(* produce true if the given number is not ZERO *)
fun is_positive n =
  case n of
       ZERO => false
     | SUCC _ => true
  
(* 10 *)
(* nat -> nat *)
(* produce nat predecessor, if ZERO throws an Negative exn *)
fun pred n = 
  case n of
       ZERO => raise Negative
     | SUCC x => x

(* 11 *)
(* nat -> int *)
(* produce the integer number of an natural number *)
fun nat_to_int n =
let
  fun helper (ZERO, acc) = acc
    | helper (SUCC x, acc) = helper (x, acc+1)
in
  helper (n, 0)
end
  
(* 12 *)
(* int -> nat*)
(* produce the natural number of an integer number *)
fun int_to_nat i =
  if i < 0 then raise Negative else
let
  fun helper (0, acc) = acc
    | helper (x, acc) = helper (x-1, SUCC acc)
in
  helper (i, ZERO)
end

(* 13 *)
(* nat * nat  -> nat *)
(* produce the sum of two natural numbers *)
fun add (n, ZERO) = n
  | add (ZERO, n) = n
  | add (SUCC x, n) = SUCC(add(x, n))
  
(* 14 *)
(* nat * nat  -> nat *)
(* produce the substraction of two natural numbers *)
fun sub (n, ZERO) = n
  | sub (ZERO, n) = raise Negative
  | sub (SUCC x, n) = sub(x, pred n) 

(* 15 *)
(* nat * nat  -> nat *)
(* produce the multiplication of two natural numbers *)
fun mult (_, ZERO) = ZERO 
  | mult (ZERO, _) = ZERO
  | mult (n, SUCC ZERO) = n
  | mult (n1, n2) = mult(add(n1,n1), pred n2) 

(* 16 *)
(* nat * nat  -> bool *)
(* produce true if n1 is less than n2 *)
fun less_than (_, ZERO) = false
  | less_than (ZERO, _) = true
  | less_than (n1, n2) = less_than(pred n1, pred n2)

(* 17 *)
(* intSet -> bool *)
(* produce true if set is empty *)
fun isEmpty s =
  case s of
       Elems [] => true
     | Range {from=x1, to=x2} => x1 = x2
     | Union (x1, x2) => isEmpty x1 andalso isEmpty x2 
     | Intersection (x1, x2) => isEmpty x1 orelse isEmpty x2
     | _ => false
  
(* 18 *)
(* intSet * int -> bool *)
(* produce true if set contains the given int *)
(* !!! *)
fun contains (s, n) = 
  false

(* 19 *)
(* intSet -> int list *)
(* produce a int list with set's elements, without duplicates *)
(* !!! *)
fun toList s = 
  []
