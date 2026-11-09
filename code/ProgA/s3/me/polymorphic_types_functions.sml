structure Timer = Timer

fun timeFunctionCall f g y =
let
  val startTime = Timer.checkRealTime ()
  val result = f (g, y)
  val endTime = Timer.checkRealTime ()
  val elapsedTime = Time.-(endTime, startTime)
in
  (result, elapsedTime)
end

fun times_until_zero (f, x) =
  if x = 0 then 0 else 1 + times_until_zero(f, f x)

(* better with tail recursion *)
fun times_until_zero_tl (f, x) =
let
  fun helper(x, acc) = 
    if x = 0
    then acc
    else helper(f x, 1 + acc)
in
  helper(x, 0)
end

val test1 = timeFunctionCall times_until_zero (fn x => x-1, 1000);
val test2 = timeFunctionCall times_until_zero_tl (fn x => x-1, 1000);
