import java.text.SimpleDateFormat;
import java.util.Date;

class CDAccount implements IBankAccount {

  int id;
  String customerName;
  double interestRate;
  Date maturity;
  int currentBalance;

  CDAccount(int id, String customerName, double interestRate, Date maturity, int currentBalance) {
    this.id = id;
    this.customerName = customerName;
    this.interestRate = interestRate;
    this.maturity = maturity;
    this.currentBalance = currentBalance;
  }

  @Override
  public String toString() {
    return this.customerName + ", id# " + this.id + ", has $" + this.currentBalance +
        " in a certificate of deposit whose interest rate is " + this.interestRate +
        "% and whose maturity date is " + new SimpleDateFormat("MMMM d, yyyy").format(
        this.maturity);
  }
}
