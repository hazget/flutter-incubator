extension FormattedDateTime on DateTime {
  String get formatted => '${year.toString().padLeft(4, '0')}.'
      '${month.toString().padLeft(2, '0')}.'
      '${day.toString().padLeft(2, '0')} '
      '${hour.toString().padLeft(2, '0')}:'
      '${minute.toString().padLeft(2, '0')}:'
      '${second.toString().padLeft(2, '0')}';
}

void main() {
  final now = DateTime.now();
  final formattedDateTime = now.formatted;

  print('Current date and time: $formattedDateTime');
}
