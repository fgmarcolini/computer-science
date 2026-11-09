package problem3;

public class Horse implements ITransportation {
  IHousing from;
  IHousing to;
  String name;
  String color;

  Horse(IHousing from, IHousing to, String name, String color){
    this.from = from;
    this.to = checkTo(to);
    this.name = name;
    this.color = color;
  }

  private IHousing checkTo(IHousing to) {
    if (!to.canReceiveHorse())
        throw new IllegalArgumentException("This horse can't travel to the given housing.");
    return to;
  }

}
