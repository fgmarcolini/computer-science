package problem3;

public interface IHousing {

  // can this housing receive a horse?
  boolean canReceiveHorse();

  // can this housing send a carriage to the given housing?
  boolean canCarriageGoTo(IHousing to);

  // can part a carriage from this housing?
  boolean canPartThisCarriage();

  // can this housing receive a carriage from an Inn?
  boolean canReceiveCarriageFromInn();

  // can this housing receive a carriage from a Castle?
  boolean canReceiveCarriageFromCastle();
}
