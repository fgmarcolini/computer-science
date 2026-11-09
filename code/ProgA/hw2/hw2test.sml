(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw2.sml";

val test1_0 = all_except_option ("string", ["string"]) = SOME [];
val test1_1 = all_except_option ("string", []) = NONE;
val test1_2 = all_except_option ("string", ["string","string2"]) = SOME ["string2"];
val test1_3 = all_except_option ("string", ["string2","string"]) = SOME ["string2"];
val test1_4 = all_except_option ("string", ["string2","string", "string3"]) =
  SOME ["string2", "string3"];

val test2_0 = get_substitutions1 ([["foo"],["there"]], "foo") = [];
val test2_1 = get_substitutions1 ([], "foo") = [];
val test2_2 = get_substitutions1 ([["foo", "there"]], "foo") = ["there"];
val test2_3 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];

val test3_0 = get_substitutions2 ([["foo"],["there"]], "foo") = [];
val test3_1 = get_substitutions2 ([], "foo") = [];
val test3_2 = get_substitutions2 ([["foo", "there"]], "foo") = ["there"];
val test3_3 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];

val test4_0 = similar_names ([["Elizabeth","Betty"]], {first="Fred", middle="W", last="Smith"}) =
  [{first="Fred", last="Smith", middle="W"}];
val test4_1 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
  [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
  {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith",
  middle="W"}];

val test5_0 = card_color (Clubs, Num 2) = Black;
val test5_1 = card_color (Spades, Num 2) = Black;
val test5_2 = card_color (Diamonds, Num 2) = Red;
val test5_3 = card_color (Hearts, Num 2) = Red;

val test6_0 = card_value (Clubs, Num 2) = 2;
val test6_1 = card_value (Clubs, Ace) = 11;
val test6_2 = card_value (Clubs, Jack) = 10;
val test6_3 = card_value (Clubs, Queen) = 10;

val test7_1 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = [];
val test7_2 = remove_card ([(Clubs, Num 1), (Hearts, Ace), (Clubs, Num 2)],
(Hearts, Ace), IllegalMove) = [(Clubs, Num 1), (Clubs, Num 2)];
val test7_3 = remove_card ([(Clubs, Num 1), (Hearts, Ace), (Clubs, Num 2), (Hearts, Ace)],
(Hearts, Ace), IllegalMove) = [(Clubs, Num 1), (Clubs, Num 2), (Hearts, Ace)];

val test8_0 = all_same_color [] = true;
val test8_1 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true;
val test8_2 = all_same_color [(Clubs, Ace), (Hearts, Ace)] = false;
val test8_3 = all_same_color [(Clubs, Ace), (Spades, Ace)] = true;

val test9_0 = sum_cards [] = 0;
val test9_1 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4;

val test10_0 = score ([],10) = 5;
val test10_1 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4;
val test10_2 = score ([(Hearts, Num 2),(Clubs, Num 4)], 4) = 6;
val test10_3 = score ([(Spades, Num 2),(Clubs, Num 4)], 4) = 3;

val test11_0 = officiate ([],[Draw], 15) = 7;
val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6;

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3;

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true);
             
             
