import tester.Tester;

/*
 * Exercise 3.1 Design a data representation for this problem:
 *  . . . Develop a “real estate assistant” program. The “assistant” helps real estate agents locate
 *  available houses for clients. The information about a house includes its kind, the number of
 *  rooms, its address, and the asking price. An address consists of a street number, a street name, and a city. . . .
 *    Represent the following examples using your classes:
 *      1. Ranch, 7 rooms, $375,000, 23 Maple Street, Brookline;
 *      2. Colonial, 9 rooms, $450,000, 5 Joye Road, Newton; and
 *      3. Cape, 6 rooms, $235,000, 83 Winslow Road, Waltham.
 */
public class ExamplesHouses {
  Address maple = new Address(23, "Maple Street", "Brookline");
  Address joye = new Address(5, "Joye Road", "Newton");
  Address winslow = new Address(83, "Winslow Road", "Waltham");
  House ranch = new House("Ranch", 7, this.maple, 375000);
  House colonial = new House("Colonial", 9, this.joye, 450000);
  House cape = new House("Cape", 6, this.winslow, 235000);

  boolean testHouses(Tester t) {
    return
        t.checkExpect(this.ranch.toString(), "Ranch, 7 rooms, $375000, 23 Maple Street, Brookline")
            &&
            t.checkExpect(this.colonial.toString(),
                "Colonial, 9 rooms, $450000, 5 Joye Road, Newton") &&
            t.checkExpect(this.cape.toString(), "Cape, 6 rooms, $235000, 83 Winslow Road, Waltham");
  }
}
