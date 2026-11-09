import tester.Tester;

/*
 * Exercise 11.2 Exercise 3.2 provides the data definition for a weather record-
 * ing program. Design the following methods for the WeatherRecord class:
 * 1. withinRange, which determines whether today’s high and low were
 * within the normal range;
 * 2. rainyDay, which determines whether the precipitation is higher than
 * some given value;
 * 3. recordDay, which determines whether the temperature broke either
 * the high or the low record
 */
public class ExamplesWeather {
  Date d1 = new Date(5, 12, 2023);
  WeatherRecord w1 = new WeatherRecord(this.d1, new TemperatureRange(35, 13),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w2 = new WeatherRecord(this.d1, new TemperatureRange(37, 13),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w3 = new WeatherRecord(this.d1, new TemperatureRange(35, 12),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w4 = new WeatherRecord(this.d1, new TemperatureRange(39, 12),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w5 = new WeatherRecord(this.d1, new TemperatureRange(35, 11),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w6 = new WeatherRecord(this.d1, new TemperatureRange(39, 11),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w7 = new WeatherRecord(this.d1, new TemperatureRange(41, 11),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);
  WeatherRecord w8 = new WeatherRecord(this.d1, new TemperatureRange(35, 9),
      new TemperatureRange(37, 12), new TemperatureRange(40, 10), 0.2);


  boolean testWeatherRecord(Tester t) {
    return
        t.checkExpect(w1.withinRange(), true) &&
            t.checkExpect(w2.withinRange(), true) &&
            t.checkExpect(w3.withinRange(), true) &&
            t.checkExpect(w4.withinRange(), false) &&
            t.checkExpect(w5.withinRange(), false) &&
            t.checkExpect(w6.withinRange(), false) &&

            t.checkExpect(w1.rainyDay(0.1), true) &&
            t.checkExpect(w1.rainyDay(0.2), false) &&
            t.checkExpect(w1.rainyDay(0.3), false) &&

            t.checkExpect(w1.recordDay(), false) &&
            t.checkExpect(w7.recordDay(), true) &&
            t.checkExpect(w8.recordDay(), true);
  }
}
