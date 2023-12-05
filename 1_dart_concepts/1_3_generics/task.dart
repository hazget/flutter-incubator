T findMax<T extends Comparable>(List<T> list) {
  if (list.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  T maxElement = list[0];
  for (int i = 1; i < list.length; i++) {
    if (list[i].compareTo(maxElement) > 0) {
      maxElement = list[i];
    }
  }

  return maxElement;
}

void main() {
  List<int> intList = [1, 5, 3, 2, 4];
  int maxInt = findMax(intList);
  print('Max int: $maxInt');

  List<double> doubleList = [1.5, 3.2, 5.4, 2.7, 4.1];
  double maxDouble = findMax(doubleList);
  print('Max double: $maxDouble');

  List<String> stringList = ['apple', 'banana', 'pineapple', 'orange'];
  String maxString = findMax(stringList);
  print('Max string: $maxString');
}
