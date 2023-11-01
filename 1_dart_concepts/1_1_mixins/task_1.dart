extension DateTimeExtension on DateTime {
  String format() {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    final second = this.second.toString().padLeft(2, '0');

    return '$year.$month.$day $hour:$minute:$second';
  }

  // String format() {
  //   return '${year.toString().padLeft(4, '0')}.${month.toString().padLeft(2, '0')}.${day.toString().padLeft(2, '0')} '
  //       '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  // }
}

void main() {
  // Implement an extension on [DateTime], returning a [String] in format of
  // `YYYY.MM.DD hh:mm:ss` (e.g. `2023.01.01 00:00:00`).
  DateTime now = DateTime.now();
  String formattedDate = now.format();
  print(formattedDate); 
}
