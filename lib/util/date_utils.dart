final class DateUtils {
  static String durationToHourMinutes(Duration duration) {
    final negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}h$twoDigitMinutes";
  }
}
