package problem2;

public class Scooped implements IIceCream{

  IIceCream more;
  String flavor;

  Scooped(IIceCream more, String flavor) {
    this.more = more;
    this.flavor = flavor;
  }

}
