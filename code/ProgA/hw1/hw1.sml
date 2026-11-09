(* 1. *)
(* (int*int*int) (int*int*int)) -> bool *)
(* produces true if d1 comes before d2 *)
fun is_older (d1 : (int*int*int), d2 : (int*int*int)) =
  (#1 d1 < #1 d2) orelse
  (#1 d1 = #1 d2 andalso #2 d1 < #2 d2) orelse
  (#1 d1 = #1 d2 andalso #2 d1 = #2 d2 andalso #3 d1 < #3 d2)

(* 2. *)
(* ((int*int*int) list) int -> int *)
(* produces how many dates in xs are in the given month *)
fun number_in_month (xs : (int*int*int) list, m : int) =
  if null xs
  then 0
  else if (#2 (hd xs) = m) 
  then 1 + number_in_month((tl xs), m)
  else number_in_month((tl xs), m)


(* 3. *)
(* ((int*int*int) list) int list -> int *) 
(* produces number of dates in xs that are in any of the months in ys *)
(* ASSUME: ys has no number repeated *)
fun number_in_months (xs : (int*int*int) list, ys : int list) =
  if null ys
  then 0
  else number_in_month(xs, (hd ys)) + number_in_months(xs, (tl ys)k


(* 4. *)
(* ((int*int*int) list) int -> (int*int*int) list *)
(* produces a list of the dates in xs that are in the given month *)
fun dates_in_month (xs : (int*int*int) list, m : int) =
  if null xs
  then [ ]
  else if (#2 (hd xs) = m)
  then (hd xs) :: dates_in_month((tl xs), m)
  else dates_in_month((tl xs), m)

(* 5. *)
(* ((int*int*int) list) int list -> (int*int*int) list *)
(* produces a list of the dates in xs that are in one of the months in ys *)
(* ASSUME: ys has no number repeated *)
fun dates_in_months (xs : (int*int*int) list, ys : int list) =
  if null ys
  then [ ]
  else dates_in_month(xs, (hd ys)) @ dates_in_months(xs, (tl ys))

(* 6. *)
(* (string list) int -> string  *)
(* produce the nth element of xs, starting with 1 *)
(* ASSUME: xs has at least one string *)
fun get_nth (xs : string list, n : int) =
  if n = 1
  then (hd xs)
  else get_nth((tl xs), n-1)

(* 7. *)
(* (int*int*int) -> string  *)
(* given a date produce a string of the form 'January 20, 2013' *)
fun date_to_string (d : int*int*int) =
let val months = ["January","February","March","April","May","June",
"July","August","September","October","November","December"]
in get_nth(months, #2 d) ^ " " ^ Int.toString (#3 d) ^ ", " ^ Int.toString (#1
d)
end


(* 8. *)
(* int (int list) -> int *)
(* produce n position in xs that the n+1 pos. sum or equal the given n *) 
(* ASSUME: xs sum to more or equal n *)
fun number_before_reaching_sum (n : int, xs : int list) =
let 
  (* last_pos is the position of the last number seen so far *)
  fun sum_to_n (xs : int list, sum : int, last_pos : int) =
    if (sum + (hd xs)) >= n
    then last_pos
    else sum_to_n((tl xs), sum + (hd xs), 1 + last_pos)
in
  sum_to_n(xs, 0, 0)
end

(* sample solution *)
(*
fun number_before_reaching_sum2 (n int, xs : int list) =
  if n <= hd xs
  then 0
  else 1 + number_before_reaching_sum2(n - hd xs, tl xs)
*)

(* 9. *)
(* int -> int *)
(* produce the month as integer of the given day *)
(* ASSUME: day between 1 and 365 *)
fun what_month (day : int) =
let val months_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
in 1 + number_before_reaching_sum(day, months_days)
end

(* 10. *)
(* int int -> int list *)
(* produce a list of the months as integers of [day1, day2] *)
fun month_range (day1 : int, day2 : int) =
  if day1 > day2
  then [ ]
  else what_month day1 :: month_range(1+day1, day2) 

(* 11. *)
(* (int*int*int) list -> (int*int*int) option *)
(* produce SOME oldest date of xs if xs isn't null. otherwise produce NONE *)
fun oldest (xs : (int*int*int) list) =
  if null xs
  then NONE  
  else
    let
      fun oldest_of_dates (ys : (int*int*int) list, oldest : int*int*int) =
        if null ys
        then oldest
        else if is_older((hd ys), oldest) (* is head older than oldest? *)
        then oldest_of_dates((tl ys), (hd ys))
        else oldest_of_dates((tl ys), oldest)
    in
      SOME (oldest_of_dates((tl xs), (hd xs))) (* at least one date in xs *)
    end

(* 12. *)
(* int list -> int list *)
(* produce a list of unique numbers in xs *)
(* ASSUME: xs is not the empty list *)
fun remove_duplicates (xs : int list) =
let
  fun n_in_lst (n : int, ys : int list) =
    not(null ys) andalso
    (n = (hd ys) orelse
     n_in_lst(n, (tl ys)))
  fun remove_duplicates_helper (xs : int list, ys : int list) =
    if null xs
    then ys
    else if n_in_lst((hd xs), ys)
    then remove_duplicates_helper ((tl xs), ys)
    else remove_duplicates_helper ((tl xs), ys @ [hd xs])
in
  remove_duplicates_helper(xs, [ ])
end

(* ((int*int*int) list) int list -> int *)
(* produces number of dates in xs that are in any of the months in ys *)
fun number_in_months_challenge (xs : (int*int*int) list, ys : int list) =
  number_in_months(xs, remove_duplicates ys)

(* ((int*int*int) list) int list -> (int*int*int) list *)
(* produces a list of the dates in xs that are in one of the months in ys *)
fun dates_in_months_challenge (xs : (int*int*int) list, ys : int list) =
  dates_in_months(xs, remove_duplicates ys)

(* 13. *)
(* int*int*int -> bool *)
(* produce true if the given date is reasonable:
* - positive year (excluding zero)
* - month in [1, 12]
* - day in [1, months_days] (month_days change if is a leap year) *)
fun reasonable_date (d : (int*int*int)) =
let
  (* Helper funcions correct_day *)
  fun leap_year (y : int) =
    (y mod 400) = 0 orelse
    ((y mod 4) = 0 andalso
    (y mod 100) <> 0)
  fun months_days (y : int) =
    if leap_year y
    then [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    else [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  fun month_days (m : int, xs : int list) =
    if null xs  (* shouldn't happen, m is [1, 12]*)
    then NONE   
    else if m = 1
    then SOME (hd xs)
    else month_days(m-1, (tl xs))

  fun correct_year (y : int) =
    y > 0
  fun correct_month (m : int) =
    m > 0 andalso m <= 13
  fun correct_day (d : (int*int*int)) =
  let
    val months_days = month_days(#2 d, months_days(#1 d))
    val month_days = if isSome months_days then valOf months_days else 0 
  in
    (#3 d) > 0 andalso 
    (#3 d) <= month_days
  end

in
  correct_year(#1 d) andalso
  correct_month(#2 d) andalso
  correct_day d
end

(* 12 and 13 sample solutions *)
(*
(* quadratic algorithm rather than sorting which is nlog n *)
fun mem(x : int, xs : int list) =
    not (null xs) andalso (x = hd xs orelse mem(x, tl xs))
fun remove_duplicates(xs : int list) =
    if null xs
    then []
    else
        let 
            val tl_ans = remove_duplicates (tl xs)
        in
            if mem(hd xs, tl_ans)
            then tl_ans
            else (hd xs)::tl_ans
        end

fun number_in_months_challenge(dates : (int * int * int) list, months : int list) =
    number_in_months(dates, remove_duplicates months)

fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
    dates_in_months(dates, remove_duplicates months)

fun reasonable_date (date : int * int * int) =
    let    
        fun get_nth (lst : int list, n : int) =
        if n=1
        then hd lst
        else get_nth(tl lst, n-1)
        val year  = #1 date
        val month = #2 date
        val day   = #3 date
        val leap  = year mod 400 = 0 orelse (year mod 4 = 0 andalso year mod 100 <> 0)
        val feb_len = if leap then 29 else 28
        val lengths = [31,feb_len,31,30,31,30,31,31,30,31,30,31]
    in
        year > 0 andalso month >= 1 andalso month <= 12
        andalso day >= 1 andalso day <= get_nth(lengths,month)
    end
*)
