package problem3;

public class Carriage implements ITransportation {
  IHousing from;
  IHousing to;
  int tonnage;

  Carriage(IHousing from, IHousing to, int tonnage){
    this.from = checkFrom(from);
    this.to = checkTo(to);
    this.tonnage = tonnage;
  }

  private IHousing checkTo(IHousing to) {
    if (!this.from.canCarriageGoTo(to))
      throw new IllegalArgumentException("This carriage can't travel to the given housing.");
    return to;
  }

  private IHousing checkFrom(IHousing from) {
    if (!from.canPartThisCarriage())
      throw new IllegalArgumentException("This carriage can't travel to the given housing.");
    return from;
  }

}
