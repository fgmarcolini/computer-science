/*
 * Exercise 5.3 Consider a revision of the problem in exercise 3.1:
 * . . . Develop a program that assists real estate agents. The program deals with listings of
 * available houses. . . . . . .
 * Make examples of listings. Develop a data definition for listings of houses.
 * Implement the definition with classes. Translate the examples into objects.
 */
public class ExamplesILoHouse {
  Address maple = new Address(23, "Maple Street", "Brookline");
  Address joye = new Address(5, "Joye Road", "Newton");
  Address winslow = new Address(83, "Winslow Road", "Waltham");
  House ranch = new House("Ranch", 7, this.maple, 375000);
  House colonial = new House("Colonial", 9, this.joye, 450000);
  House cape = new House("Cape", 6, this.winslow, 235000);
  ILoHouse empty = new MtLoHouse();
  ILoHouse lst1 = new ConsLoHouse(this.ranch, this.empty);
  ILoHouse lst2 = new ConsLoHouse(this.cape, new ConsLoHouse(this.colonial, this.lst1));

}
