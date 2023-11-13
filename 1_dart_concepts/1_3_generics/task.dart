T findMaxElement<T extends Comparable<dynamic>>(List<T> list) {
  if (list.isEmpty) {
    throw ArgumentError('List cannot be null or empty');
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
  List<int> intList = [1, 3, 5, 7, 9, 6, 11, 2];
  List<String> stringList = ['apple', 'banana', 'cherry', 'null', 'empty'];

  print(findMaxElement(intList)); 
  print(findMaxElement(stringList)); 
}
