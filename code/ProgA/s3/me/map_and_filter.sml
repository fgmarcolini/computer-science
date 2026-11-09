(* produces a list with f applied to each element *)
fun map (f, xs) =
  case xs of
       [] => []
     | x::xs' => (f x)::map(f, xs')

(* produces a list with each element that produces true p *)
fun filter (p, xs) =
  case xs of
       [] => []
     | x::xs' => if (p x) then x::filter(p, xs') else filter(p, xs')

