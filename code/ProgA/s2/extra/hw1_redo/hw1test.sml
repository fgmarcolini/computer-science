use "hw1.sml";
(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1_1 = is_older ((1,2,3),(2,3,4)) = true;  (* year greater *)
val test1_2 = is_older ((1,2,3),(1,3,4)) = true;  (* s/year month greater *)
val test1_3 = is_older ((1,2,3),(1,2,4)) = true;  (* s/year s/month day greater *)
val test1_4 = is_older ((1,2,3),(1,2,3)) = false; (* same date *)
val test1_5 = is_older ((1,2,3),(1,2,2)) = false; (* day lesser *)
val test1_6 = is_older ((1,2,3),(1,1,3)) = false; (* month lesser *)
val test1_7 = is_older ((2,2,3),(1,2,3)) = false; (* year lesser *)

val test2_1 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1;
val test2_2 = number_in_month ([(2012,3,28),(2013,12,1)],2) = 0;
val test2_3 = number_in_month ([ ],2) = 0;

val test3_1 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3;
val test3_2 = number_in_months ([],[2,3,4]) = 0;
val test3_3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0;
val test3_4 = number_in_months ([(2012,2,28),(2013,2,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 4;

val test4_1 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)];
val test4_2 = dates_in_month ([(2012,2,28),(2013,12,1)],1) = [];
val test4_3 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)];
val test4_4 = dates_in_month ([],2) = [];

val test5_1 = dates_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 
[(2012,2,28),(2011,3,31),(2011,4,28)];
val test5_2 = dates_in_months
([],[2,3,4]) = 
[];
val test5_3 = dates_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 
[];
val test5_4 = dates_in_months
([(2012,2,28),(2013,2,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 
[(2012,2,28),(2013,2,1),(2011,3,31),(2011,4,28)];

val test6_1 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there";
val test6_2 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi";
val test6_3 = get_nth (["hi"], 1) = "hi";


val test7_1 = date_to_string (2013, 6, 1) = "June 1, 2013";
val test7_2 = date_to_string (2023, 5, 31) = "May 31, 2023";


val test8_1 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3;
val test8_2 = number_before_reaching_sum (15, [1,2,3,4,5]) = 4;
val test8_3 = number_before_reaching_sum (3, [1,2,3,4,5]) = 1;
val test8_4 = number_before_reaching_sum (10, [1,3,4,2]) = 3; (* 1+3+4+2 =
  10, so the last before 10 is 4 in pos. 3 *)

val test9_0 = what_month 1  = 1;
val test9_1 = what_month 70 = 3;
val test9_2 = what_month 31 = 1;
val test9_3 = what_month 59 = 2;
val test9_4 = what_month 60 = 3;

val test10_1 = month_range (31, 34) = [1,2,2,2];
val test10_2 = month_range (58, 62) = [2,2,3,3,3];
val test10_3 = month_range (1, 3) = [1,1,1];

val test11_0 = oldest([]) = NONE;
val test11_1 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31);
val test11_2 = oldest([(2012,2,28),(2011,4,31),(2011,3,28)]) = SOME (2011,3,28);

val test12_1 = number_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,2,4]) = 3;
val test12_2 = number_in_months_challenge
([(2012,2,28),(2013,2,1),(2011,3,31),(2011,4,28)],[2,4,3,2,4]) = 4;


val test12_3 = dates_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,3,4]) = 
[(2012,2,28),(2011,3,31),(2011,4,28)];
val test12_4 = dates_in_months_challenge
([(2012,2,28),(2013,2,1),(2011,3,31),(2011,4,28)],[2,3,3,4,4]) = 
[(2012,2,28),(2013,2,1),(2011,3,31),(2011,4,28)];

val test13_1 = reasonable_date (2012, 2, 28) = true;
val test13_2 = reasonable_date (0, 2, 28) = false;
val test13_3 = reasonable_date (2012, 13, 28) = false;
val test13_4 = reasonable_date (2015, 2, 29) = false;
val test13_5 = reasonable_date (2016, 2, 29) = true; (* leap year *)
