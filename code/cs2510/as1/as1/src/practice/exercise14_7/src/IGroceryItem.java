// to represent an item of the grocery
public interface IGroceryItem {
  // computes the unit price (cents per gram) of this grocery item
  double unitPrice();

  // if the unit price of this grocery item is lower than the given amount.
  boolean lowerUnitPrice(double amount);

  // if this grocery item's unit price is less than some other item's unit price.
  boolean cheaperThan(IGroceryItem other);

}
