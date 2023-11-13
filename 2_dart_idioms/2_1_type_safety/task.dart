import 'dart:async';

/// Represents a user in the system.
class UserId {
  /// Creates a new instance of [UserId] with the specified [id].
  ///
  /// The [id] should be a 36-character string in UUIDv4 format.
  /// For more information on UUIDv4, refer to [Universally_unique_identifier].
  ///
  /// [Universally_unique_identifier]: https://en.wikipedia.org/wiki/Universally_unique_identifier
  const UserId(this.id);

  /// The unique identifier for the user.
  final String id;
}

/// Represents user data, including their name and biography.
class UserData {
  /// Creates a new instance of [UserData].
  ///
  /// The [name] should be between 4 and 32 characters long, containing only alphabetical letters.
  /// The [bio] should be no longer than 255 characters.
  const UserData({
    required this.name,
    required this.bio,
  });

  /// The name of the user.
  final String name;

  /// The biography of the user.
  final String bio;
}

/// Represents a user in the system with extended details.
class User {
  /// Creates a new instance of [User].
  ///
  /// The [id] should be a 36-character string in UUIDv4 format.
  /// For more information on UUIDv4, refer to [Universally_unique_identifier].
  ///
  /// [Universally_unique_identifier]: https://en.wikipedia.org/wiki/Universally_unique_identifier
  const User({
    required this.id,
    required this.userData,
  });

  /// The unique identifier for the user.
  final UserId id;

  /// Additional user data including name and biography.
  final UserData userData;
}

/// Represents the backend service for user-related operations.
class Backend {
  /// Retrieves a user from the backend with the specified [id].
  Future<User> getUser(String id) async => User(id: UserId(id), userData: UserData(name: 'Roman', bio: '32 years'));

  /// Updates user information in the backend.
  Future<void> putUser(User user) async {}
}

/// Represents a service for managing user-related operations.
class UserService {
  /// Creates a new instance of [UserService].
  ///
  /// The [backend] parameter represents the backend service for user-related operations.
  UserService(this.backend);

  /// The backend service for user-related operations.
  final Backend backend;

  /// Retrieves user information from the backend for the specified [id].
  Future<User> get(String id) async => backend.getUser(id);

  /// Updates user information in the backend.
  Future<void> update(User user) async => backend.putUser(user);
}

Future<void> main() async {
  // Example usage
  final backend = Backend();
  final userService = UserService(backend);

  final user = await userService.get('exampleId');
  print('Retrieved user: ${user.userData.name}');
}
