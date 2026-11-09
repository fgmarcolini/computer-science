(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* 1a. *)
(* string * string list -> string list option *)
(* produce SOME list without str if str is in list, otherwise NONE *)
(* ASSUME: str is in lst at most once *)
fun all_except_option(str, lst) =
let
  fun aux([], acc) = NONE
    | aux(x::xs', acc) =
     if same_string(x, str)
     then SOME (acc @ xs')
     else aux(xs', acc @ [x])
in
  aux(lst, [])
end

(* 1b. *)
(* string list list * string -> string list *)
(* produce strings of the lists that have str, getting rid of str *)
fun get_substitutions1([], _) = []
  | get_substitutions1(xs::xss', str) =
  case all_except_option(str, xs) of
       NONE => get_substitutions1(xss', str)
     | SOME x => x @ get_substitutions1(xss', str)

(* 1c. *)
(* string list list * string -> string list *)
(* produce strings of the lists that have str, getting rid of str using tail
* recursion *)
fun get_substitutions2(xss, str) =
let
  fun aux([], acc) = acc
    | aux(xs::xss', acc) =
    case all_except_option(str, xs) of
         NONE => aux(xss', acc)
       | SOME x => aux(xss', acc @ x)
in
  aux(xss, [])
end

(* 1d. *)
(* string list list * {first:string,middle:string,last:string} ->
* {first:string,middle:string,last:string} list *)
(* produce list of full names, which first name is similar to first field *)
fun similar_names(xss, {first=first, middle=middle, last=last}) =
let
  fun full_names([], acc) = acc
    | full_names(x::xs', acc) = full_names(xs', acc @
    [{first=x,last=last,middle=middle}]) 
in
  full_names(get_substitutions2(xss, first),
  [{first=first,middle=middle,last=last}])
end

(* 2a. *)
(* card -> color *)
(* produce the color of the card: spades and clubs are black, diamonds and hearts are red *)
fun card_color (Clubs, _) = Black
  | card_color (Spades, _) = Black
  | card_color (_,_) = Red

(* 2b. *)
(* card -> int *)
(* produces the value of the card: Num are int, Ace are 11, others are 10 *)
fun card_value (_, Num x) = x 
  | card_value (_, Ace)   = 11
  | card_value (_, _)     = 10

(* 2c. *)
(* card list * card * exn -> card list *)
(* produces a list with all cards of cs except c, if appears more than once,
* remove the first one *)
fun remove_card ([], _, e) = raise e
  | remove_card (cs::cs', c, e) =
  if cs=c
  then cs'
  else cs::remove_card(cs', c, e)

(* 2d. *)
(* card list -> boolean *)
(* produces true if all cards in cs has the same color *)
fun all_same_color ([]) = true
  | all_same_color (x::[]) = true
  | all_same_color (x::(y::z')) = 
    card_color x = card_color y andalso 
    all_same_color(y::z')

(* 2e. *)
(* card list -> int *)
(* produce sum of card values in cs *)
fun sum_cards cs  = 
let
  fun aux ([], acc) = acc
    | aux (c::cs', acc) = aux(cs', card_value(c) + acc)
in
  aux(cs, 0)
end
  
(* 2f. *)
(* card list * int -> int *)
(* computes the score of the play *)
fun score ([], goal) = goal div 2
  | score (cs, goal) = 
  let 
    val sum = sum_cards cs
    val pre_score = if sum >= goal then 3*(sum-goal) else (goal-sum)
    val score = if all_same_color(cs) then pre_score div 2 else pre_score
  in
    score
  end

(* 2g. *)
(* card list * move list * int -> int *)
(* produces the score at the end of the game *)
fun officiate (cards, moves, goal) = 
let
  (* aux (deck, moves, hand, goal) *)
  fun aux (_, [], hand, goal) = score(hand, goal)
    | aux (deck, Discard c::moves ,hand, goal) = 
    aux(deck, moves, remove_card(hand, c, IllegalMove), goal)
    | aux ([], Draw::moves, hand, goal) = score(hand, goal)
    | aux (c::deck, Draw::moves, hand, goal) =
    let val hand_new = c::hand
    in
      if sum_cards hand_new >= goal
      then score (hand_new, goal)
      else aux (deck, moves, hand_new, goal)
    end
in
  aux (cards, moves, [], goal)
end
