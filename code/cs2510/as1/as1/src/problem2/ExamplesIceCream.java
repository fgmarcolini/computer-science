package problem2;

public class ExamplesIceCream {

  IIceCream ic1 = new Scooped(new Scooped(
      new Scooped(new Scooped(new EmptyServing(false), "caramel swirl"), "black raspberry"),
      "coffee"), "mint chip");

  IIceCream ic2 = new Scooped(
      new Scooped(new Scooped(new EmptyServing(true), "strawberry"), "vanilla"), "chocolate");

}
