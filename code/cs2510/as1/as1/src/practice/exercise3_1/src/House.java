class House {

  String kind;
  int numRooms;
  Address address;
  int price;

  House(String kind, int numRooms, Address address, int price) {
    this.kind = kind;
    this.numRooms = numRooms;
    this.address = address;
    this.price = price;
  }

  @Override
  public String toString() {
    return this.kind + ", " + this.numRooms + " rooms, $" + this.price + ", "
        + this.address.toString();
  }
}
