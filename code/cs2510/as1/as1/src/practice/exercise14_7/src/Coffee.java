public class Coffee implements IGroceryItem {

  String name;
  double weight; // grams
  double price; // cents
  boolean isDecaffeinated;

  Coffee(String name, double weight, double price, boolean isDecaffeinated) {
    this.name = name;
    this.weight = weight;
    this.price = price;
    this.isDecaffeinated = isDecaffeinated;
  }

  // computes the unit price (cents per gram) of this Coffee
  @Override
  public double unitPrice() {
    return price/weight;
  }

  // if the unit price of this Coffee is lower than the given amount.
  @Override
  public boolean lowerUnitPrice(double amount) {
    return unitPrice() < amount;
  }

  // if this Coffee's unit price is less than some other item's unit price.
  @Override
  public boolean cheaperThan(IGroceryItem other) {
    return !other.lowerUnitPrice(this.unitPrice());
  }
}
