package problem3;

public class Inn implements IHousing {

  String name;
  int capacity;
  int population; // must be less than the capacity
  int stalls;

  Inn(String name, int capacity, int population, int stalls) {
    this.name = name;
    this.capacity = capacity;
    this.population = checkPopulation(population);
    this.stalls = stalls;
  }

  private int checkPopulation(int population) {
    if (population > this.capacity) {
      throw new IllegalArgumentException(
          "The current population can't be more than the capacity of the Inn.");
    }
    return population;
  }

  // can this Inn receive a horse?
  @Override
  public boolean canReceiveHorse() {
    return this.stalls > 0;
  }

  // can this Inn send a carriage to the given housing?
  @Override
  public boolean canCarriageGoTo(IHousing to) {
    return to.canReceiveCarriageFromInn();
  }

  // can part a carriage from this Inn?
  @Override
  public boolean canPartThisCarriage() {
    return true;
  }

  // can this Inn receive a carriage from an Inn?
  @Override
  public boolean canReceiveCarriageFromInn() {
    return false;
  }

  // can this Castle receive a carriage from a Castle?
  @Override
  public boolean canReceiveCarriageFromCastle() {
    return true;
  }
}
