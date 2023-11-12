// void main() {
//   // Implement a method, returning the maximum element from a `Comparable` list.
//   // You must use generics to allow different types usage with that method.
// }

T findMax<T extends Comparable>(List<T> list) {
  if (list.isEmpty) {
    throw ArgumentError('The list cannot be empty.');
  }

  T max = list[0];

  for (var element in list) {
    if (element.compareTo(max) > 0) {
      max = element;
    }
  }

  return max;
}

void main() {
  List<int> intList = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
  int maxInt = findMax(intList);
  print('Максимальное целое число: $maxInt');

  List<double> doubleList = [3.14, 2.71, 1.62, 2.5, 1.0];
  double maxDouble = findMax(doubleList);
  print('Максимальное вещественное число: $maxDouble');

  List<String> stringList = ['apple', 'banana', 'cherry', 'date'];
  String maxString = findMax(stringList);
  print('Максимальная строка: $maxString');
}

