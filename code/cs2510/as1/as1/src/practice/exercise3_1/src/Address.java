class Address {

  int streetNum;
  String streetName;
  String city;

  Address(int streetNum, String streetName, String city) {
    this.streetNum = streetNum;
    this.streetName = streetName;
    this.city = city;
  }

  @Override
  public String toString() {
    return this.streetNum + " " + this.streetName + ", " + this.city;
  }
}
