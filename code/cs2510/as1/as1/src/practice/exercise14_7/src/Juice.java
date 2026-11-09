public class Juice implements IGroceryItem {

  String name;
  double weight; // grams
  double price; // cents
  String flavor;
  JuicePackage packaged;

  Juice(String name, double weight, double price, String flavor, JuicePackage packaged) {
    this.name = name;
    this.weight = weight;
    this.price = price;
    this.flavor = flavor;
    this.packaged = packaged;
  }

  // computes the unit price (cents per gram) of this Juice
  @Override
  public double unitPrice() {
    return price/weight;
  }

  // if the unit price of this Juice is lower than the given amount.
  @Override
  public boolean lowerUnitPrice(double amount) {
    return unitPrice() < amount;
  }

  // if this Juice's unit price is less than some other item's unit price.
  @Override
  public boolean cheaperThan(IGroceryItem other) {
    return !other.lowerUnitPrice(this.unitPrice());
  }
}
