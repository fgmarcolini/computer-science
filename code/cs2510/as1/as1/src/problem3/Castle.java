package problem3;

public class Castle implements IHousing {

  String name;
  String familyName;
  int population;
  int carriages;

  Castle(String name, String familyName, int population, int carriages) {
    this.name = name;
    this.familyName = familyName;
    this.population = population;
    this.carriages = carriages;
  }

  // can this Castle receive a horse?
  @Override
  public boolean canReceiveHorse() {
    return true;
  }

  // can this Castle send a carriage to the given housing?
  @Override
  public boolean canCarriageGoTo(IHousing to) {
    return to.canReceiveCarriageFromCastle();
  }

  // can part a carriage from this Castle?
  @Override
  public boolean canPartThisCarriage() {
    return true;
  }

  // can this Castle receive a carriage from an Inn?
  @Override
  public boolean canReceiveCarriageFromInn() {
    return true;
  }

  // can this Castle receive a carriage from a Castle?
  @Override
  public boolean canReceiveCarriageFromCastle() {
    return false;
  }
}
