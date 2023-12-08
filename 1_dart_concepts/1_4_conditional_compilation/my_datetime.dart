import 'package:meta/meta.dart' show visibleForTesting;
export 'src/my_datetime_native.dart'
    if (dart.library.html) 'src/my_datetime_web.dart';

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
    return _dateTime.microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return _dateTime.toString();
  }
}
