class AppLogger {
  static void log(String message, {String tag = "APP"}) {
    print("[$tag] $message");
  }

  static void error(String message, {String tag = "APP"}) {
    print("[ERROR][$tag] $message");
  }
}
