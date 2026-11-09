import java.util.Calendar;
import java.util.GregorianCalendar;
import tester.Tester;

/*
 * Exercise 4.4 Design a data representation for this problem:
 * . . . Develop a “bank account” program. The program keeps track of the balances
 * in a person’s bank accounts. Each account has an id number and a customer’s name.
 * There are three kinds of accounts: a checking account, a savings account, and a certificate of
 * deposit (CD). Checking account information also includes the minimum balance.
 * Savings account includes the interest rate. A CD specifies the interest rate and the maturity
 * date. Naturally, all three types come with a current balance. . . .
 * Represent the following examples using your classes:
 *    1. Earl Gray, id# 1729, has $1,250 in a checking account with minimum balance of $500;
 *    2. Ima Flatt, id# 4104, has $10,123 in a certificate of deposit whose interest rate is 4% and
 *       whose maturity date is June 1, 2005;
 *    3. Annie Proulx, id# 2992, has $800 in a savings account; the account yields interest at the
 *       rate of 3.5%.
 */
public class ExamplesIBankAccounts {
  IBankAccount earl = new CheckingAccount(1729, "Earl Gray", 500, 1250);
  IBankAccount ima = new CDAccount(4104, "Ima Flatt", 4, new GregorianCalendar(2005,
      Calendar.JUNE, 1).getTime(), 10123);
  IBankAccount annie = new SavingsAccount(2992, "Annie Proulx", 3.5, 800);

  boolean testBankAccounts(Tester t) {
    return
        t.checkExpect(this.earl.toString(),
            "Earl Gray, id# 1729, has $1250 in a checking account with minimum balance of $500") &&
            t.checkExpect(this.ima.toString(),
                "Ima Flatt, id# 4104, has $10123 in a certificate of deposit whose interest" +
                    " rate is 4.0% and whose maturity date is June 1, 2005") &&
            t.checkExpect(this.annie.toString(),
                "Annie Proulx, id# 2992, has $800 in a savings account; the account yields interest at the rate of 3.5%");
  }
}
