package problem3;

public class ExamplesHousing {

  IHousing hovel = new Hun(5, 1);
  IHousing hun2 = new Hun(6, 0);
  IHousing winterfell = new Castle("Winterfell", "Stark", 500, 6);
  IHousing volkihar = new Castle("Castle Volkihar", "Volkihar", 200, 5);
  IHousing crossroads = new Inn("Inn At The Crossroads", 40, 20, 12);
  IHousing beeAndBarb = new Inn("The Bee and Barb", 30, 10, 5);

  ITransportation h1 = new Horse(this.winterfell, this.beeAndBarb, "Silver", "White");
  ITransportation h2 = new Horse(this.beeAndBarb, this.hun2, "Black", "White");
  ITransportation h3 = new Carriage(this.volkihar, this.crossroads, 120);
  ITransportation h4 = new Carriage(this.crossroads, this.winterfell, 90);

}
