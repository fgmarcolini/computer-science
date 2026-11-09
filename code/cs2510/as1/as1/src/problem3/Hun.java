package problem3;

public class Hun implements IHousing {

  int capacity;
  int population; // must be less than the capacity

  Hun(int capacity, int population) {
    this.capacity = capacity;
    this.population = checkPopulation(population);
  }

  private int checkPopulation(int population) {
    if (population > this.capacity) {
      throw new IllegalArgumentException(
          "The current population can't be more than the capacity of the Hun.");
    }
    return population;
  }

  // can this Hun receive a horse?
  @Override
  public boolean canReceiveHorse() {
    return true;
  }

  // can this Hun send a carriage to the given housing?
  @Override
  public boolean canCarriageGoTo(IHousing to) {
    return false;
  }

  // can part a carriage from this Hun?
  @Override
  public boolean canPartThisCarriage() {
    return false;
  }

  // can this Hun receive a carriage from an Inn?
  @Override
  public boolean canReceiveCarriageFromInn() {
    return false;
  }

  // can this Hun receive a carriage from a Castle?
  @Override
  public boolean canReceiveCarriageFromCastle() {
    return false;
  }
}
