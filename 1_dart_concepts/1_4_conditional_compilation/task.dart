class MyDateTime {
 final DateTime _dateTime;

 MyDateTime(this._dateTime);

 int get microseconds => _dateTime.microsecondsSinceEpoch;

 String format(String formatString) {
    return _dateTime.toString();
 }
  
}
void main() {
 MyDateTime myDateTime = MyDateTime(DateTime.now());

 print('Microseconds since epoch: ${myDateTime.microseconds}');
 print('Formatted date: ${myDateTime.format('yyyy-MM-dd HH:mm:ss')}');
}
