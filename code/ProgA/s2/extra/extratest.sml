use "extra.sml";

val test1_0 = pass_or_fail {grade=NONE, id=1234} = fail;
val test1_1 = pass_or_fail {grade=SOME 74, id=1234} = fail;
val test1_2 = pass_or_fail {grade=SOME 90, id=1235} = pass;

val test2_0 = has_passed {grade=NONE, id=1234} = false;
val test2_1 = has_passed {grade=SOME 74, id=1234} = false;
val test2_2 = has_passed {grade=SOME 90, id=1235} = true;

val test3_0 = number_passed [{grade=NONE, id=1234}] = 0 ;
val test3_1 = number_passed [{grade=NONE, id=1234}, {grade=SOME 90, id=1235}] = 1 ;
val test3_2 = number_passed [{grade=NONE, id=1234}, {grade=SOME 90, id=1235},
{grade=SOME 75, id=1236}] = 2 ;

val test4_0 = number_misgraded [(fail, {grade=NONE, id=1234})] = 0 ;
val test4_1 = number_misgraded [(fail, {grade=NONE, id=1234}), (fail, {grade=SOME 90, id=1235})] = 1 ;
val test4_1 = number_misgraded [(fail, {grade=NONE, id=1234}), (fail,{grade=SOME 90, id=1235}), (pass, {grade=SOME 75, id=1236})] = 1 ;

val test5_0 = tree_height leaf = 0;
val test5_1 = tree_height (node {value=10, left=leaf, right=leaf}) = 1;
val test5_2 = tree_height (node {value=10, left= (node {value=15, left=leaf, right=leaf}), right=leaf}) = 2;

val test6_0 = sum_tree leaf = 0;
val test6_1 = sum_tree (node {value=10, left=leaf, right=leaf}) = 10;
val test6_2 = sum_tree (node {value=10, left= (node {value=15, left=leaf,
right=leaf}), right=leaf}) = 25;

val test8_1 = last [] = [] 
    handle Empty => true
      | _ => false;
val test8_2 = last [1,2,3,4] = 4;
val test8_3 = take ([1,2,3,4], 0) = [];
val test8_4 = take ([1,2,3,4], 2) = [1,2];
val test8_5 = take ([1,2,3,4], 4) = [1,2,3,4];
val test8_6 = drop ([1,2,3,4], 0) = [1,2,3,4];
val test8_7 = drop ([1,2,3,4], 2) = [3,4];
val test8_8 = drop ([1,2,3,4], 4) = [];
val test8_9 = concat [] = [];
val test8_10 = concat [[1]] = [1];
val test8_11 = concat [[1,2,3], [4,5,6]] = [1,2,3,4,5,6];
val test8_12 = concat2 [] = [];
val test8_13 = concat2 [[1]] = [1];
val test8_14 = concat2 [[1,2,3], [4,5,6]] = [1,2,3,4,5,6];
val test8_15 = getOpt (NONE, 0) = 0;
val test8_16 = getOpt (SOME 1, 0) = 1;
val test8_17 = join (SOME (NONE)) = NONE;
val test8_18 = join (SOME (SOME 1)) = SOME 1;
val test8_19 = join NONE = NONE;

val test9_0 = is_positive ZERO = false;
val test9_1 = is_positive(SUCC ZERO) = true;
val test9_2 = is_positive(SUCC (SUCC ZERO)) = true;

val test10_0 = (pred ZERO = ZERO) handle Negative => true;
val test10_1 = pred (SUCC ZERO) = ZERO;
val test10_2 = pred (SUCC (SUCC ZERO)) = SUCC ZERO;

val test11_0 = nat_to_int ZERO = 0;
val test11_1 = nat_to_int (SUCC (SUCC ZERO)) = 2;

val test12_0 = int_to_nat 0 = ZERO;
val test12_1 = int_to_nat 2 = SUCC (SUCC ZERO);
val test12_2 = (int_to_nat (~ 1) = ZERO) handle Negative => true;

val test13_0 = add (ZERO, ZERO) = ZERO;
val test13_1 = add (ZERO, SUCC ZERO) = SUCC ZERO;
val test13_2 = add (SUCC ZERO, ZERO) = SUCC ZERO;
val test13_3 = add (SUCC ZERO, SUCC ZERO) = SUCC (SUCC ZERO);
val test13_4 = add (SUCC (SUCC ZERO), SUCC ZERO) = SUCC (SUCC (SUCC ZERO));

val test14_0 = sub (ZERO, ZERO) = ZERO;
val test14_1 = (sub (ZERO, SUCC ZERO) = SUCC ZERO) handle Negative => true;
val test14_2 = sub (SUCC ZERO, ZERO) = SUCC ZERO;
val test14_3 = sub (SUCC ZERO, SUCC ZERO) = ZERO;
val test14_4 = sub (SUCC (SUCC ZERO), SUCC ZERO) = SUCC ZERO;

val test15_0 = mult (ZERO, ZERO) = ZERO;
val test15_1 = mult (ZERO, SUCC ZERO) = ZERO;
val test15_2 = mult (SUCC ZERO, ZERO) = ZERO;
val test15_3 = mult (SUCC ZERO, SUCC ZERO) = SUCC ZERO;
val test15_4 = mult (SUCC (SUCC ZERO), SUCC (SUCC ZERO)) = int_to_nat 4;

val test16_0 = less_than (ZERO, ZERO) = false;
val test16_1 = less_than (SUCC ZERO, ZERO) = false;
val test16_2 = less_than (ZERO, SUCC ZERO) = true;
val test16_3 = less_than (SUCC ZERO, SUCC (SUCC ZERO)) = true;

val test17_0 = isEmpty (Elems []) = true;
val test17_1 = isEmpty (Elems [1,2]) = false;
val test17_2 = isEmpty (Range {from=0, to=0}) = true;
val test17_3 = isEmpty (Range {from=0, to=1}) = false;
val test17_4 = isEmpty (Union (Elems [], Elems [])) = true;
val test17_5 = isEmpty (Union (Elems [1,2], Elems [])) = false;
val test17_6 = isEmpty (Intersection (Elems [1,2], Elems [])) = true;
val test17_7 = isEmpty (Intersection (Elems [1,2], Elems [1,2])) = false;


val test18_0 = contains (Elems [], 1) = false;
val test18_1 = contains (Elems [1,2], 1) = true;
val test18_2 = contains (Range {from=0, to=0}, 1) = false;
val test18_3 = contains (Range {from=0, to=1}, 1) = true;
val test18_4 = contains (Union (Elems [], Elems []), 1) = false;
val test18_5 = contains (Union (Elems [1,2], Elems []), 1) = true;
val test18_6 = contains (Intersection (Elems [1,2], Elems []), 1) = false;
val test18_7 = contains (Intersection (Elems [1,2], Elems [1,2]), 1) = true;

val test19_0 = toList (Elems []) = [];
val test19_1 = toList (Elems [1,2]) = [1,2];
val test19_2 = toList (Range {from=0, to=0}) = [];
val test19_3 = toList (Range {from=0, to=1}) = [0,1];
val test19_4 = toList (Union (Elems [], Elems [])) = [];
val test19_5 = toList (Union (Elems [1,2], Elems [])) = [1,2];
val test19_6 = toList (Intersection (Elems [1,2], Elems [])) = [];
val test19_7 = toList (Intersection (Elems [1,2], Elems [1,2])) = [1,2];
