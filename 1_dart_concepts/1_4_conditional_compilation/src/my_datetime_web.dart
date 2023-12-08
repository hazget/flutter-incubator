import '../my_datetime.dart';

class MyDateTime {
  final DateTime _dateTime;

  MyDateTime(this._dateTime);

  factory MyDateTime.now() {
    // Implement your custom logic for getting current DateTime on the web platform
    return MyDateTime(DateTime.now());
  }

  @visibleForTesting
  factory MyDateTime.fromDateTime(DateTime dateTime) {
    return MyDateTime(dateTime);
  }

  int get microsecondsSinceEpoch {
    // Implement your custom logic for getting microseconds since epoch on the web platform
    return _dateTime.millisecondsSinceEpoch * 1000;
  }

  @override
  String toString() {
    return _dateTime.toString();
  }
}
