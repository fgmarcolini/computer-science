use "extra.sml";

fun test_function1(x : int) : int option =
  if x > 0 then SOME(x) else NONE

fun test_function2(x : int) : int option =
  if x mod 2 = 0 then SOME(x * 2) else NONE

val test1_1 = compose_opt test_function1 test_function2 3 = NONE;
val test1_2 = compose_opt test_function1 test_function2 4 = SOME 8;
val test1_3 = compose_opt test_function2 test_function1 5 = NONE;
val test1_4 = compose_opt test_function2 test_function1 6 = SOME 12;

val test2_1 = do_until (fn x => x div 2) (fn x => x mod 2 <> 1) 18 = 9;
val test2_2 = do_until (fn x => x div 2) (fn x => x mod 2 <> 1) 6 = 3;
val test2_3 = do_until (fn x => x div 2) (fn x => x mod 2 <> 1) 5 = 5;
val test2_4 = do_until (fn x => x + 10) (fn x => x <= 100) 3 = 103;

val test3_0 = fact_do_until 0 = 1;
val test3_1 = fact_do_until 1 = 1;
val test3_2 = fact_do_until 6 = 720;

val test4_1 = fixed_point (fn x => x div 2) 17 = 0;
val test4_2 = fixed_point (fn x => x) 17 = 17;

val test5_0 = map2 (fn x => x) (0, 0) = (0, 0);
val test5_1 = map2 (fn x => x*2) (1, 2) = (2, 4);
val test5_2 = map2 (fn x => String.size x) ("A", "ABC") = (1, 3);

val test6_0 = app_all (fn n => [n, 2 * n, 3 * n]) (fn n => [n, 2 * n, 3 * n]) 1 = [1, 2, 3, 2, 4, 6, 3, 6, 9];
val test6_1 = app_all (fn n => [n, 2 * n, 3 * n]) (fn _ => []) 1 = [];
val test6_2 = app_all (fn _ => []) (fn n => [n, 2 * n, 3 * n]) 1 = [];
val test6_3 = app_all String.explode (map Int.toString) [12, 34, 56] = [#"1", #"2", #"3", #"4", #"5", #"6"];

val test7_1 = foldr (op +) 42 [] = 42;
val test7_2 = foldr (op ^) "#" ["ab", "cd", "ef"] = "abcdef#";

val test8_1 = partition (fn x => x>3) [1,2,3,4,5,6] = ([1,2,3],[4,5,6]);
val test8_2 = partition (fn x => String.size x >= 1) ["abc", "bcd", "c", "h"] =
  (["abc", "bcd"], ["c", "h"]);

