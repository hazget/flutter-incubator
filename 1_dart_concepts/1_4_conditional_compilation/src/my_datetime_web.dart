import 'package:meta/meta.dart';


class MyDateTime {
  final DateTime _dateTime;

  MyDateTime(this._dateTime);

  factory MyDateTime.now() {
    return MyDateTime(DateTime.now());
  }

  @visibleForTesting
  factory MyDateTime.fromDateTime(DateTime dateTime) {
    return MyDateTime(dateTime);
  }

  int get microsecondsSinceEpoch {
    return _dateTime.millisecondsSinceEpoch * 1000;
  }

  @override
  String toString() {
    return _dateTime.toString();
  }
}
