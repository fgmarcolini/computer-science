class SavingsAccount implements IBankAccount {

  int id;
  String customerName;
  double interestRate;
  int currentBalance;

  SavingsAccount(int id, String customerName, double interestRate, int currentBalance) {
    this.id = id;
    this.customerName = customerName;
    this.interestRate = interestRate;
    this.currentBalance = currentBalance;
  }

  @Override
  public String toString() {
    return this.customerName + ", id# " + this.id + ", has $" + this.currentBalance +
        " in a savings account; the account yields interest at the rate of " + this.interestRate
        + "%";
  }
}
