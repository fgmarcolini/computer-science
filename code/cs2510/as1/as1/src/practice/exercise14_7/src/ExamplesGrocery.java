import tester.Tester;

/*
 * Exercise 14.7 A software house that is working with a grocery chain re-
 * ceives this problem statement:
 * . . . Develop a program that keeps track of the items in the
 * grocery store. For now, assume that the store deals only with
 * ice cream, coffee, and juice. Each of the items is specified by
 * its brand name (String), weight (grams) and price (cents). Each
 * coffee is also labeled as either regular or decaffeinated. Juice
 * items come in different flavors, and can be packaged as frozen,
 * fresh, bottled, or canned. Each package of ice cream specifies its
 * flavor. . . .
 * Design the following methods:
 * 1. unitPrice, which computes the unit price (cents per gram) of a grocery
 * item;
 * 2. lowerUnitPrice, which determines whether the unit price of a grocery
 * item is lower than some given amount;
 * 3. cheaperThan, which determines whether a grocery item’s unit price is
 * less than some other (presumably) comparable item’s unit price
 */
public class ExamplesGrocery {
  IGroceryItem i1 = new IceCream("Mint", 300, 3.4, "Mint");
  IGroceryItem i2 = new Coffee("Black coffee", 200, 3, false);
  IGroceryItem i3 = new Coffee("Black coffee", 200, 3, true);
  IGroceryItem i4 = new Juice("Orange Juice", 200, 2, "Orange", JuicePackage.FRESH);

  boolean testUnitPrice(Tester t){
    return
        t.checkInexact(this.i1.unitPrice(), 0.011, 0.1) &&
            t.checkInexact(this.i2.unitPrice(), 0.015, 0.1) &&
            t.checkInexact(this.i4.unitPrice(), 0.01, 0.1);
  }

  boolean testLowerUnitPrice(Tester t){
    return
        t.checkExpect(this.i1.lowerUnitPrice(0.1), true) &&
            t.checkExpect(this.i1.lowerUnitPrice(0.011), false) &&
            t.checkExpect(this.i1.lowerUnitPrice(0.010), false) &&
            t.checkExpect(this.i2.lowerUnitPrice(0.016), true) &&
            t.checkExpect(this.i4.lowerUnitPrice(0.009), false);
  }

  boolean testCheaperThan(Tester t){
    return
        t.checkExpect(this.i1.cheaperThan(this.i2), true) &&
            t.checkExpect(this.i1.cheaperThan(this.i4), false);
  }

}
