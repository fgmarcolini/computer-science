use "extra.sml";

val test1_0 = alternate([]) = 0;
val test1_1 = alternate([1,2,3,4]) = ~2;
val test1_2 = alternate([1,2,3,4,5]) = 3;

val test2_1 = min_max([1,2,3,4]) = (1, 4);
val test2_2 = min_max([1]) = (1, 1);
val test2_3 = min_max([4,3,2,1]) = (1, 4);

val test3_0 = cumsum([]) = [];
val test3_1 = cumsum([1,4,20]) = [1,5,25];
val test3_2 = cumsum([1,4,20,30]) = [1,5,25,55];

val test4_0 = greeting NONE = "Hello there, you!";
val test4_1 = greeting(SOME "Gabi") = "Hello there, Gabi!";

val test5_0 = repeat([], []) = [];
val test5_1 = repeat([], [1,2,3]) = [];
val test5_2 = repeat([1,2,3], []) = [];
val test5_3 = repeat([1,2,3], [4,0,3]) = [1,1,1,1,3,3,3];

val test6_0 = addOpt(NONE,NONE) = NONE;
val test6_1 = addOpt(SOME 2,NONE) = NONE;
val test6_2 = addOpt(NONE,SOME 3) = NONE;
val test6_3 = addOpt(SOME 2,SOME 3) = SOME 5;

val test7_0 = addAllOpt [] = NONE;
val test7_1 = addAllOpt [NONE,NONE] = NONE;
val test7_2 = addAllOpt [SOME 1, NONE, SOME 3] = SOME 4;

val test8_0 = any [] = false;
val test8_1 = any [false,false,false] = false;
val test8_2 = any [false,true,false] = true;

val test9_0 = all [] = true;
val test9_1 = all [true,true,true] = true;
val test9_2 = all [true,true,false] = false;

val test10_0 = zip([], []) = [];
val test10_1 = zip([1,2], []) = [];
val test10_2 = zip([], [3,4]) = [];
val test10_3 = zip([1,2,3], [4,6]) = [(1,4),(2,6)];

val test11_0 = zipRecycle([], []) = [];
val test11_1 = zipRecycle([1,2,3], [4,6]) = [(1,4),(2,6),(3,4)];
val test11_2 = zipRecycle([1,2,3], [1,2,3,4,5,6,7]) =
  [(1,1),(2,2),(3,3),(1,4),(2,5),(3,6),(1,7)];


val test12_0 = zipOpt([], []) = SOME [];
val test12_1 = zipOpt([1,2], []) = NONE;
val test12_2 = zipOpt([], [3,4]) = NONE;
val test12_3 = zipOpt([1,2,3], [4,6]) = NONE;
val test12_4 = zipOpt([1,2], [4,6]) = SOME [(1,4),(2,6)];

val test13_0 = lookup([], "") = NONE;
val test13_1 = lookup([("a",1), ("b",2)], "c") = NONE;
val test13_2 = lookup([("a",1), ("b",2)], "b") = SOME 2;

val test14_0 = splitup [] = ([], []);
val test14_1 = splitup [1,2,3] = ([1,2,3], []);
val test14_2 = splitup [~1,~2,~3] = ([], [~1,~2,~3]);
val test14_3 = splitup [1,~2,3] = ([1,3], [~2]);

val test15_0 = splitAt([], 0) = ([], []);
val test15_1 = splitAt([1,2,3], 2) = ([2,3], [1]);
val test15_2 = splitAt([~1,~2,~3], ~1) = ([~1], [~2,~3]);
val test15_3 = splitAt([1,~2,3],0) = ([1,3], [~2]);

val test16_0 = isSorted [] = true;
val test16_1 = isSorted [1] = true;
val test16_2 = isSorted [1,2,3,4] = true;
val test16_3 = isSorted [1,3,2,4] = false;

val test17_0 = anySorted [] = true;
val test17_1 = anySorted [1] = true;
val test17_2 = anySorted [1,2,3,4] = true;
val test17_3 = anySorted [4,3,2,1] = true;
val test17_4 = anySorted [1,3,2,4] = false;

val test18_0 = sortedMerge([],[]) = [];
val test18_1 = sortedMerge([1,2,3],[]) = [1,2,3];
val test18_2 = sortedMerge([],[4,5,6]) = [4,5,6];
val test18_3 = sortedMerge([1,4,7],[5,8,9]) = [1,4,5,7,8,9];

val test19_0 = qsort [] = [];
val test19_1 = qsort [1,2,3,4,5] = [1,2,3,4,5];
val test19_3 = qsort [1,3,2,5,4] = [1,2,3,4,5];
val test19_4 = qsort [5,4,3,2,1] = [1,2,3,4,5];

val test20_0 = divide [] = ([], []);
val test20_1 = divide [1] = ([1], []);
val test20_2 = divide [1,2] = ([1], [2]);
val test20_3 = divide [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6]);

val test21_0 = not_so_quick_sort [] = [];
val test21_1 = not_so_quick_sort [1,2,3,4,5] = [1,2,3,4,5];
val test21_3 = not_so_quick_sort [1,3,2,5,4] = [1,2,3,4,5];
val test21_4 = not_so_quick_sort [5,4,3,2,1] = [1,2,3,4,5];
