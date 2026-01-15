class UserModel {
  final String uid;
  final String email;
  final String username;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
  });

  // Фабричный конструктор для создания UserModel из данных Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }
}