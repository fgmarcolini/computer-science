(* University of Washington, Programming Languages, Homework 7
   hw7testsprovided.sml *)
(* Will not compile until you implement preprocess and eval_prog *)

(* These tests do NOT cover all the various cases, especially for intersection *)

use "hw7.sml";

(* Must implement preprocess_prog and Shift before running these tests *)

fun real_equal(x,y) = Real.compare(x,y) = General.EQUAL;

(* Preprocess tests *)
let
	val Point(a,b) = preprocess_prog(LineSegment(3.2,4.1,3.2,4.1))
	val Point(c,d) = Point(3.2,4.1)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "preprocess converts a LineSegment to a Point successfully\n")
	else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,~4.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(4.2,4.1,~3.2,~4.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,4.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,5.1,3.2,4.1))
	val LineSegment(e,f,g,h) = LineSegment(3.2,4.1,3.2,5.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,3.8,3.2,4.1))
	val LineSegment(e,f,g,h) = LineSegment(3.2,3.8,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

(* extra tests for preprocess_prog *)
let 
  val Intersect(Point(x1,y1), Point(x2,y2)) = preprocess_prog (Intersect
  (LineSegment(~3.7,1.5,~3.7,1.5), LineSegment(~3.7,1.5,~3.7,1.5)))
  val Point(a,b) = Point(~3.7,1.5)
in
  if real_equal(x1, a) andalso real_equal(x2, a) andalso real_equal(y1, b)
  andalso real_equal(y2, b)
	then (print "preprocess converts a LineSegment to a Point successfully\n")
	else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let 
  val Let(_, Point(x1, y1), Point(x2, y2)) = (preprocess_prog (Let
    ("x",LineSegment(~3.7,1.5,~3.7,1.5),LineSegment(~3.7,1.5,~3.7,1.5))))
  val Point(a,b) = Point(~3.7,1.5)
in
  if real_equal(x1, a) andalso real_equal(x2, a) andalso real_equal(y1, b)
  andalso real_equal(y2, b)
	then (print "preprocess converts a LineSegment to a Point successfully\n")
	else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let 
  val Shift(_, _, Point(x1, y1)) = (preprocess_prog
  (Shift(5.5,~1.2,LineSegment(~3.7,1.5,~3.7,1.5))))
  val Point(a,b) = Point(~3.7,1.5)
in
  if real_equal(x1, a) andalso real_equal(y1, b)
	then (print "preprocess converts a LineSegment to a Point successfully\n")
	else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let 
  val Intersect(LineSegment(x1, y1, x2, y2), _) = 
    (preprocess_prog
    (Intersect(LineSegment(1.0,1.0,0.0,0.0),LineSegment(1.0,1.0,0.0,0.0))))
  val LineSegment(a,b,c,d) = LineSegment(0.0,0.0,1.0,1.0)
in
  if real_equal(x1, a) andalso real_equal(y1, b) andalso real_equal(x2, c)
  andalso real_equal(y2, d) 
	then (print "preprocess flips a LineSegment successfully\n")
	else (print "preprocess does not flip a LineSegment succesfully\n")
end;

let 
  val Let("y",LineSegment(x1, y1, x2, y2), _) = 
    (preprocess_prog
    (Let("y",LineSegment(1.0,1.0,0.0,0.0),LineSegment(1.0,1.0,0.0,0.0))))
  val LineSegment(a,b,c,d) = LineSegment(0.0,0.0,1.0,1.0)
in
  if real_equal(x1, a) andalso real_equal(y1, b) andalso real_equal(x2, c)
  andalso real_equal(y2, d) 
	then (print "preprocess flips a LineSegment successfully\n")
	else (print "preprocess does not flip a LineSegment succesfully\n")
end;

let 
  val Shift(_,_,LineSegment(x1, y1, x2, y2)) = 
    (preprocess_prog
    (Shift(1.0,1.0,LineSegment(1.0,1.0,0.0,0.0))))
  val LineSegment(a,b,c,d) = LineSegment(0.0,0.0,1.0,1.0)
in
  if real_equal(x1, a) andalso real_equal(y1, b) andalso real_equal(x2, c)
  andalso real_equal(y2, d) 
	then (print "preprocess flips a LineSegment successfully\n")
	else (print "preprocess does not flip a LineSegment succesfully\n")
end;

let 
  val LineSegment(x1, y1, x2, y2) = (preprocess_prog (LineSegment(0.5,2.0,0.4,2.0)))
  val LineSegment(a, b, c, d) = LineSegment(0.4,2.0,0.5,2.0)
in
  if real_equal(x1, a) andalso real_equal(y1, b) andalso real_equal(x2, c)
  andalso real_equal(y2, d) 
	then (print "preprocess flips a LineSegment successfully\n")
	else (print "preprocess does not flip a LineSegment succesfully\n")
end;

(* eval_prog tests with Shift*)
let 
	val Point(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Point(4.0,4.0))), []))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with empty environment worked\n")
	else (print "eval_prog with empty environment is not working properly\n")
end;

(* Using a Var *)
let 
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))]))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with 'a' in environment is working properly\n")
	else (print "eval_prog with 'a' in environment is not working properly\n")
end;


(* With Variable Shadowing *)
let 
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))]))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with shadowing 'a' in environment is working properly\n")
	else (print "eval_prog with shadowing 'a' in environment is not working properly\n")
end;

(* With Line *)
let 
	val Line(m,b) = (eval_prog (preprocess_prog (Shift(2.0, 5.0, Line(4.0,4.0))), []))
	val Line(c,d) = Line(4.0,1.0) 
in
	if real_equal(m,c) andalso real_equal(b,d)
	then (print "eval_prog with line worked\n")
	else (print "eval_prog with line is not working properly\n")
end;

(* With Vertical Line *)
let 
	val VerticalLine(x) = (eval_prog (preprocess_prog (Shift(2.0, 5.0, VerticalLine(4.0))), []))
	val VerticalLine(y) = VerticalLine(6.0) 
in
	if real_equal(x,y)
	then (print "eval_prog with a vertical line worked\n")
	else (print "eval_prog with a vertical line is not working properly\n")
end;

(* With Line Segment *)
let 
	val LineSegment(x1, y1, x2, y2) = (eval_prog (preprocess_prog (Shift(2.0, 5.0, LineSegment(2.0, 2.0, 4.0, 4.0))), []))
	val LineSegment(a1, b1, a2, b2) = LineSegment(4.0, 7.0, 6.0, 9.0) 
in
	if real_close_point (x1, y1) (a1, b1) andalso real_close_point (x2, y2) (a2, b2)
	then (print "eval_prog with a line segment worked\n")
	else (print "eval_prog with a line segment is not working properly\n")
end;

(* Intersect tests *)
let 
  val test = Intersect(Point(1.0, 2.0), Point(1.0, 2.0))
  val Point(x, y) = eval_prog(preprocess_prog test, []) (* result of test *)
  val Point(a, b) = Point(1.0, 2.0) (* expected *)
in
  if real_close(x, a) andalso real_close(y, b)
  then (print "eval_prog with intersect between two points worked\n")
  else (print "eval_prog with intersect between two points is not working\n")
end;

let 
  val test = Intersect(Line(1.0, 0.0), Line(1.0, 0.0))
  val Line(x, y) = eval_prog(preprocess_prog test, []) (* result of test *)
  val Line(a, b) = Line(1.0, 0.0) (* expected *)
in
  if real_close(x, a) andalso real_close(y, b)
  then (print "eval_prog with between intersect two lines worked\n")
  else (print "eval_prog with between intersect two lines is not working\n")
end;

let 
  val test = Intersect(VerticalLine(2.0), VerticalLine(2.0))
  val VerticalLine(x) = eval_prog(preprocess_prog test, []) (* result of test *)
  val VerticalLine(a) = VerticalLine(2.0) (* expected *)
in
  if real_close(x, a)
  then (print "eval_prog with intersect between two vertical lines worked\n")
  else (print "eval_prog with intersect between two vertical lines is not working\n")
end;

let 
  val test = Intersect(LineSegment(0.0,0.0,2.0,2.0), Point(1.0, 1.0))
  val Point(x, y) = eval_prog(preprocess_prog test, []) (* result of test *)
  val Point(a, b) = Point(1.0, 1.0) (* expected *)
in
  if real_close(x, a) andalso real_close(y, b)
  then (print "eval_prog with intersect between a line segment and a point worked\n")
  else (print "eval_prog with intersect between a line segment and a point is not working\n")
end;

let 
  val test = Intersect(LineSegment(0.0,0.0,2.0,2.0), Line(1.0, 0.0))
  val LineSegment(x1, y1, x2, y2) = eval_prog(preprocess_prog test, []) (* result of test *)
  val LineSegment(a, b, c, d) = LineSegment(0.0, 0.0, 2.0, 2.0) (* expected *)
in
  if real_close(x1, a) andalso real_close(y1, b) andalso real_close(x2, c) andalso real_close(y2, d)
  then (print "eval_prog with intersect between a line segment and a line worked\n")
  else (print "eval_prog with intersect between a line segment and a line is not working\n")
end;

let 
  val test = Intersect(LineSegment(0.0,0.0,2.0,2.0), VerticalLine(2.0))
  val Point(x, y) = eval_prog(preprocess_prog test, []) (* result of test *)
  val Point(a, b) = Point(2.0, 2.0) (* expected *)
in
  if real_close(x, a) andalso real_close(y, b)
  then (print "eval_prog with intersect between a line segment and a vertical line worked\n")
  else (print "eval_prog with intersect between a line segment and a vertical line is not working\n")
end;

let 
  val test = Intersect(LineSegment(0.0,0.0,2.0,2.0), LineSegment(1.0, 1.0, 3.0,
  3.0))
  val LineSegment(x1, y1, x2, y2) = eval_prog(preprocess_prog test, []) (* result of test *)
  val LineSegment(a, b, c, d) = LineSegment(1.0, 1.0, 2.0, 2.0) (* expected *)
in
  if real_close(x1, a) andalso real_close(y1, b) andalso real_close(x2, c) andalso
  real_close(y2, d)
  then (print "eval_prog with intersect between two line segments worked\n")
  else (print "eval_prog with intersect between two line segments is not working\n")
end;
