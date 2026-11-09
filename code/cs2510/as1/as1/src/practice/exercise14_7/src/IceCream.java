public class IceCream implements IGroceryItem {

  String name;
  double weight; // grams
  double price; // cents
  String flavor;

  IceCream(String name, double weight, double price, String flavor) {
    this.name = name;
    this.weight = weight;
    this.price = price;
    this.flavor = flavor;
  }

  // computes the unit price (cents per gram) of this IceCream
  @Override
  public double unitPrice() {
    return price/weight;
  }

  // if the unit price of this IceCream is lower than the given amount.
  @Override
  public boolean lowerUnitPrice(double amount) {
    return unitPrice() < amount;
  }

  // if this IceCream's unit price is less than some other item's unit price.
  @Override
  public boolean cheaperThan(IGroceryItem other) {
    return !other.lowerUnitPrice(this.unitPrice());
  }
}
