datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

fun eval e = 
  case e of
       Constant i => i
     | Negate e2 => ~ (eval e2)
     | Add(e1, e2) => (eval e1) + (eval e2)
     | Multiply(e1, e2) => (eval e1) * (eval e2)


(* exp -> int *)
(* produce the largest constant in a given exp *)
fun largest e = 
let 
  fun largest_between(x, y) = 
  let 
    val largest_x = largest x 
    val largest_y = largest y
  in
    if largest_x >= largest_y
    then largest_x
    else largest_y
  end
in
  case e of 
       Constant i => i
     | Negate e1 => largest e1
     | Add(e1, e2) => largest_between(e1, e2)
     | Multiply(e1, e2) => largest_between(e1, e2) 
 end


(* exp -> int list *)
(* produce a list of all constants in exp *)
fun constants e = 
  case e of
       Constant i => [i]
     | Negate e1 => constants e1
     | Add(e1, e2) => (constants e1)@(constants e2)
     | Multiply(e1,e2) => (constants e1)@(constants e2)

(* exp -> bool *)
(* produce true if found at least one multiplication, otherwise false *)
fun there_is_multiplication (Constant _) = false
  | there_is_multiplication (Negate _) = false
  | there_is_multiplication (Add(e1,e2)) = there_is_multiplication e1 orelse
  there_is_multiplication e2
  | there_is_multiplication (Multiply(_,_)) = true

(* exp -> int *)
(* produce number of adds in an exp *)
fun num_of_adds (Constant i) = 0
  | num_of_adds (Negate e1) = 0
  | num_of_adds (Add(e1,e2) = 1 + num_of_adds e1 + num_of_adds e2
  | num_of_adds (Multiply(e1,e2)) = num_of_adds e1 + num_of_adds e2
