(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer
datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1. *)
(* string list -> string list *)
(* produce list with only the strings that start with an uppercase letter *)
fun only_capitals xs =
  List.filter (fn x => Char.isUpper (String.sub (x, 0))) xs

(* 2. *)
(* string list -> string *)
(* produce the longest string in the list. If empty "", if tie return closest to
* beginning *)
fun longest_string1 xs = 
  List.foldl (fn (x, acc) => if String.size x > String.size acc then x else acc) "" xs

(* 3. *)
(* string list -> string *)
(* produce the longest string in the list. If empty "", if tie return closest to
* end *)
fun longest_string2 xs = 
  List.foldl (fn (x, acc) => if String.size x >= String.size acc then x else acc) "" xs

(* 4. *) 
(* (int * int -> bool) -> string list -> string *)
(* produce the longest string in the list. If empty "", if tie depends on the fn
* that was passed *)
fun longest_string_helper comp xs = 
  List.foldl (fn (x, acc) => if comp(String.size x, String.size acc)
                             then x
                             else acc) "" xs

val longest_string3 = longest_string_helper (fn (x,y) => x>y) 
val longest_string4 = longest_string_helper (fn (x,y) => x>=y) 
 
(* 5. *)
(* string list -> string *) 
(* produce the longest string that begins with an uppercase letter. if none "" *)
val longest_capitalized = longest_string1 o only_capitals
  
(* 6. *)
(* string -> string *)
(* produce the reverse string of s *)
val rev_string  = (String.implode o List.rev o String.explode)  

(* 7 *)
(* ('a -> 'b option) -> 'a list -> 'b *)
(* produce the first v in lst that produce SOME v, if NONE raise exn NoAnswer *)
fun first_answer f lst = 
  case lst of
       [] => raise NoAnswer 
     | x::xs =>
         case f x of
              NONE => first_answer f xs
            | SOME v => v

(* 8 *)
(* ('a -> 'b list option) -> 'a list -> 'b list option *)
(* produce SOME list of all elements in lst, if every element returns SOME lst
* on f. otherwise if one produces NONE, all_answers produces NONE *)
fun all_answers f lst =
let
  fun helper [] acc = SOME acc
    | helper (x::xs') acc = 
        case f x of 
             NONE => NONE
           | SOME lst => helper xs' (acc @ lst) 
in
  helper lst []
end


(* 9 *)
(* pattern -> int *)
(* produce how many Wildcard patters it contains p *) 
fun count_wildcards p = g (fn _ => 1) (fn _ => 0) p

(* pattern -> int *)
(* produce how number of wildcards it contains p plus string size of variables *)
fun count_wild_and_variable_lengths p = g (fn _ => 1) String.size p

(* string * pattern -> int *) 
(* produce how many times s appears in variables of p *)
fun count_some_var (s, p) = g (fn _ => 0) (fn str => if str = s then 1 else 0) p
  
(* 10 *)
(* pattern -> bool *)
(* produces true if all the variables in p are distinct *)
fun check_pat p = 
let 
  fun pat_to_lst p acc = 
    case p of
         Variable x => x::acc
       | ConstructorP (_, pn) => pat_to_lst pn acc
       | TupleP lst => List.foldl (fn (pn, accs) => pat_to_lst pn accs) acc lst
       | _ => acc
  fun has_duplicates ([]) = false
    | has_duplicates (hd::tl) = (List.exists (fn s => s=hd) tl) orelse has_duplicates tl
in
 not (has_duplicates (pat_to_lst p []))
end

            
(* 11 *)
(* valu * pattern -> (string * valu) list option *)
(* produce SOME lst with all matches. If a pattern doesn't match NONE *)
fun match (_, Wildcard) = SOME [] 
  | match (v, Variable s) = SOME [(s, v)]
  | match (Unit, UnitP) = SOME []
  | match (Const n1, ConstP n2) = if n1=n2 then SOME [] else NONE
  | match (Tuple vs, TupleP ps) = 
    if length vs = length ps 
    then all_answers match (ListPair.zip (vs, ps))
    else NONE
  | match (Constructor (s1, v), ConstructorP (s2, p)) = 
    if s1=s2 
    then match (v, p) 
    else NONE
  | match (_, _) = NONE
  

(* 12 *)
(* valu * pattern list -> (string * valu) list option *)
(* produce SOME lst where lst are the bindings for the first p in ps that
* matches v. If no pattern matches, produces NONE *)
fun first_match v ps =
  (SOME (first_answer (fn p => match (v, p)) ps)) 
  handle NoAnswer => NONE
