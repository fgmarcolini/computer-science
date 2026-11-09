// to represent a list of houses non-empty
class ConsLoHouse implements ILoHouse{

  House first;
  ILoHouse rest;

  ConsLoHouse(House first, ILoHouse rest) {
    this.first = first;
    this.rest = rest;
  }
}
