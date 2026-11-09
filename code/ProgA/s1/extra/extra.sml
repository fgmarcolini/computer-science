(* 1. *)
(* int list -> int *)
(* produce sum of list of numbers with alternating sign *)
(*fun alternate(xs : int list) =
let
  fun helper(xs : int list, b : bool, rst : int) =
    if null xs then rst
    else if b
    then helper(tl xs, false, rst + hd xs)
    else helper(tl xs, true, rst - hd xs)
in
  helper(xs, true, 0)
end*)

(* clean solution *)
fun alternate(xs : int list) = 
  if null xs then 0 
  else hd xs - alternate(tl xs)


(* 2. *)
(* int list -> int * int *)
(* produces a pair of the min and max of the numbers in xs *)
(* ASSUME: xs is not empty *)
fun min_max(xs : int list) =
let
  fun find_min (xs : int list, min : int) =
    if null xs
    then min
    else if (hd xs) < min
    then find_min(tl xs, hd xs)
    else find_min(tl xs, min)    
  fun find_max (xs : int list, max : int) = 
    if null xs
    then max
    else if (hd xs) > max
    then find_max(tl xs, hd xs)
    else find_max(tl xs, max)    
in
  (find_min(xs, hd xs), find_max(xs, hd xs))
end

(* 3. *)
(* int list -> int list *)
(* produce a list of the partial sums of the numbers in xs *)
fun cumsum (xs : int list) =
let
  fun partial_list (xs : int list, partial : int) =
    if null xs
    then [ ]
    else 
    let val partial_sum = partial + hd xs
    in partial_sum :: partial_list (tl xs, partial_sum)
    end
in
  partial_list (xs, 0)
end

(* 4. *)
(* string option -> string *)
(* produces a greeting message with given name, if none just use "you" *)
fun greeting (name : string option) =
  if isSome name
  then "Hello there, " ^ valOf name ^ "!"
  else "Hello there, you!"

(* 5. *)
(* int list * int list -> int list *)
(* produce a list with the xs numbers repeated acording to the ys list *)
fun repeat (xs : int list, ys : int list) =
  if null xs orelse null ys
  then []
  else if hd ys > 0
  then (hd xs) :: repeat(xs, (hd ys - 1) :: tl ys)
  else repeat(tl xs, tl ys)


(* 6. *)
(* int option * int option -> int option *)
(* produce option sum of numbers if BOTH are present, otherwise NONE *)
fun addOpt (x : int option, y : int option) = 
  if isSome x andalso isSome y
  then SOME(valOf x + valOf y)
  else NONE

(* 7. *)
(* int option list -> int option *)
(* produce option sum of the present elements of xs, otherwise NONE *)
fun addAllOpt (xs : int option list) = 
  if null xs
  then NONE
  else
    let 
      fun helper(ys : int option list, sumOpt : int option) =
        if null ys then sumOpt
        else if not(isSome sumOpt)
        then helper(tl ys, hd ys)
        else if not(isSome (hd ys))
        then helper(tl ys, sumOpt)
        else SOME (valOf (hd ys) + valOf (sumOpt))
    in
      helper(xs, NONE)
    end


(* 8. *)
(* bool list -> bool *)
(* produce true if at least one is true, otherwise produce false *)
fun any (xs : bool list) =
  not(null xs) andalso
  (hd xs orelse
  any(tl xs))

(* 9. *)
(* bool list -> bool *)
(* produce true if all of xs values is true, otherwise produce false *)
fun all (xs : bool list) =
  null xs orelse
  (hd xs andalso all(tl xs))

(* 10. *)
(* int list * int list -> int * int list *)
(* produce consecutive pairs of xs and ys respective positions, and stops when
* one is empty *)
fun zip (xs : int list, ys : int list) = 
  if null xs orelse null ys
  then []
  else (hd xs, hd ys) :: zip(tl xs, tl ys)

(* Helper function for next problems *)
fun size (xs : int list) =
  if null xs
  then 0
  else 1 + size (tl xs)

(* 11. *)
(* int list * int list -> int * int list *)
(* produce zip pairs but when one is empty it starts recycling from start *)
fun zipRecycle (xs : int list, ys : int list) =
  []

(* 12. *)
(* int list * int list -> (int * int) list option *)
(* produce some list when xs and ys have same length, otherwise none *)
fun zipOpt (xs : int list, ys : int list) = 
  if size xs <> size ys
  then NONE
  else SOME (zip(xs, ys))

(* 13. *)
(* (string * int) list * string -> int option *) 
(* produce SOME int if s2 is found in xs, otherwise NONE *)
fun lookup (xs : (string*int) list, s2 : string) =
  if null xs
  then NONE
  else
    let 
      val s = #1 (hd xs)
      val i = #2 (hd xs)
    in
      if s = s2
      then SOME i
      else lookup(tl xs, s2) 
    end

(* 14. *)
(* int list -> int list * int list) *)
(* produce a pair with one positive list of xs and one negative list *)
(* ASSUME: zero counts as positive number *)
fun splitup (xs : int list) =
let 
  fun helper (xs : int list, pos : int list, neg : int list) =
    if null xs
    then (pos, neg)
    else if (hd xs) >= 0
    then helper(tl xs, pos @ [(hd xs)], neg)
    else helper(tl xs, pos, neg @ [(hd xs)])
in 
  helper(xs, [], [])
end

(* 15. *)
(* int list * int -> int list * int list) *)
(* produce a pair with ones greater/equal than n and ones lesser than n *)
fun splitAt (xs : int list, n : int) =
let 
  fun helper (xs : int list, higher : int list, lesser : int list) =
    if null xs
    then (higher, lesser)
    else if (hd xs) > n
    then helper(tl xs, higher @ [(hd xs)], lesser)
    else helper(tl xs, higher, lesser @ [(hd xs)])
in 
  helper(xs, [], [])
end

(* 16. *)
(* int list -> boolean *)
(* produce true if the list is sorted in increasing order, otherwise false *)
fun isSorted (xs : int list) =
  null xs orelse
let 
  fun helper (xs : int list, ys : int list) =
    null ys orelse
    ((hd xs <= hd ys) andalso 
    helper(tl xs, tl ys))
in
  helper(xs, tl xs)
end

(* 17. *)
(* int list -> boolean *)
(* produce true if xs is sorted either in increasing or descreasing order *)
fun anySorted (xs : int list) =
let 
  fun reverse_list (xs : int list) =
    if null xs
    then []
    else reverse_list(tl xs) @ [(hd xs)]
in
  isSorted xs orelse
  isSorted(reverse_list(xs))
end

(* 18. *)
(* int list * int list -> int list *)
(* merge two list sorted from smallest to largest into one list *)
fun sortedMerge (xs : int list, ys : int list) =
  if null ys
  then xs
  else if null xs
  then ys
  else
    if (hd xs) < (hd ys)
    then (hd xs) :: sortedMerge(tl xs, ys)
    else (hd ys) :: sortedMerge(xs, tl ys)

(* splitAt version for qsort  *)
(* int list * int -> int list * int list) *)
(* produce a pair with list parted in two*)
fun splitAt2 (xs : int list, n : int) =
let 
  fun helper (xs : int list, prev : int list) =
    if null xs
    then (prev, [])
    else if (hd xs) = n
    then (prev, tl xs)
    else helper(tl xs, prev @ [(hd xs)])
in 
  helper(xs, [])
end

(* 19. *)
(* int list -> int list *)
(* produce xs sorted in increasing order *)
fun qsort (xs : int list) = 
  if null xs then [] 
  else if null (tl xs) then xs 
  else 
    let
      val v = splitAt(tl xs, hd xs)
    in
      sortedMerge(hd xs :: qsort(#1 v), qsort(#2 v))
    end

(* 20. *)
(* int list -> int list * int list *)
(* produce two lists with alternating elements of xs *)
fun divide (xs : int list) =
  if null xs then ([], [])
  else
    let 
      fun helper(xs : int list, d1 : int list, d2 : int list, b : bool) =
        if null xs then (d1, d2)
        else if b then helper(tl xs, d1 @ [(hd xs)], d2, false)
        else helper(tl xs, d1, d2 @ [(hd xs)], true)
    in
      helper(xs, [], [], true)
    end

(* 20. *)
(* int list -> int list *)
(* produce xs sorted in increasing order *)
fun not_so_quick_sort (xs : int list) = 
  if null xs then [] 
  else if null (tl xs) then xs 
  else 
    let
      val v = divide xs
    in
      sortedMerge(not_so_quick_sort(#1 v), not_so_quick_sort(#2 v))
    end
