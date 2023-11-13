import 'dart:isolate';

void main() async {
  final N = 100000; // Replace with your desired value of N

  final responsePort = ReceivePort();

  await Isolate.spawn(calculatePrimes, responsePort.sendPort);

  final sendPort = await responsePort.first as SendPort;

  final receivePort = ReceivePort();
  sendPort.send({'start': 1, 'end': N, 'port': receivePort.sendPort});

  final result = await receivePort.first as int;
  print('Sum of prime numbers from 1 to $N: $result');

  responsePort.close();
}

void calculatePrimes(SendPort sendPort) {
  final port = ReceivePort();
  sendPort.send(port.sendPort);

  port.listen((message) {
    if (message is Map) {
      final start = message['start'];
      final end = message['end'];
      final responsePort = message['port'];

      final sum = calculateSumOfPrimes(start, end);
      responsePort.send(sum);
    }
  });
}

int calculateSumOfPrimes(int start, int end) {
  int sum = 0;

  for (int number = start; number <= end; number++) {
    if (isPrime(number)) {
      sum += number;
    }
  }

  return sum;
}

bool isPrime(int number) {
  if (number < 2) {
    return false;
  }

  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}
