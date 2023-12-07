import 'dart:async';
import 'dart:math';

class UserId {
  const UserId(this.id);

  final String id;
}

class UserData {
  const UserData({
    required this.name,
    required this.bio,
  });

  final String name;
  final String bio;
}

class User {
  const User({
    required this.id,
    required this.userData,
  });

  final UserId id;
  final UserData userData;
}

class Backend {
  Future<User> getUser(UserId id) async {
    final randomName = generateRandomName();
    final randomBio = generateRandomBio();
    return User(id: id, userData: UserData(name: randomName, bio: randomBio));
  }

  Future<void> putUser(User user) async {
    print('Обновление информации о пользователе:');
    print('ID: ${user.id.id}');
    print('Имя: ${user.userData.name}');
    print('Биография: ${user.userData.bio}');
  }
}

class UserService {
  UserService(this.backend);

  final Backend backend;

  Future<User> get(UserId id) async => backend.getUser(id);

  Future<void> update(User user) async => backend.putUser(user);
}

String generateRandomName() {
  final names = ['John', 'Jane', 'Michael', 'Emily', 'David'];
  final randomIndex = Random().nextInt(names.length);
  return names[randomIndex];
}

String generateRandomBio() {
  final bios = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem.',
    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
    'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  ];
  final randomIndex = Random().nextInt(bios.length);
  return bios[randomIndex];
}

Future<void> main() async {
  final backend = Backend();
  final userService = UserService(backend);
  final user = await userService.get(UserId('exampleId'));
  print(
      'Полученный пользователь: ${user.userData.name} (${user.userData.bio})');

  final updatedUser = User(
    id: user.id,
    userData: UserData(name: 'New Name', bio: 'New Bio'),
  );

  await userService.update(updatedUser);
  print('Информация о пользователе обновлена');

  await backend.putUser(updatedUser); // Вызов функции putUser для демонстрации
}
