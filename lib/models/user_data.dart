class User {
  final String userName;
  final String password;

  const User({required this.userName, required this.password});
}

// User copy ({
//    String? userName,
//    String? password,
// }) => User(userName: userName ?? this.userName, password: password);
