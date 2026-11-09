class WeatherRecord {

  Date d;
  TemperatureRange today;
  TemperatureRange normal;
  TemperatureRange record;
  double precipitation;

  WeatherRecord(Date d, TemperatureRange today, TemperatureRange normal, TemperatureRange record,
      double precipitation) {
    this.d = d;
    this.today = today;
    this.normal = normal;
    this.record = record;
    this.precipitation = precipitation;
  }

  // if today's temperature were within the normal range
  boolean withinRange() {
    int normalHigh = this.normal.getHigh();
    int normalLow = this.normal.getLow();
    int todayHigh = this.today.getHigh();
    int todayLow = this.today.getLow();

    return (todayLow >= normalLow && todayLow <= normalHigh) &&
        (todayHigh >= normalLow && todayHigh <= normalHigh);
  }

  // if this day precipitation is higher than the given one
  boolean rainyDay(double prec) {
    return (this.precipitation > prec);
  }

  // if today's temperature broke either the high or the low record.
  boolean recordDay() {
    return (this.today.getHigh() > this.record.getHigh()) ||
        (this.today.getLow() < this.record.getLow());
  }
}
