class CheckingAccount implements IBankAccount {

  int id;
  String customerName;
  int minBalance;
  int currentBalance;

  CheckingAccount(int id, String customerName, int minBalance, int currentBalance) {
    this.id = id;
    this.customerName = customerName;
    this.minBalance = minBalance;
    this.currentBalance = currentBalance;
  }

  @Override
  public String toString() {
    return this.customerName + ", id# " + this.id + ", has $" + this.currentBalance +
        " in a checking account with minimum balance of $" + this.minBalance;
  }
}
