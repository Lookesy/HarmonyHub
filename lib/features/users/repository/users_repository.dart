import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmonyhubhest/features/users/user_model.dart';

class UsersRepository {
  final FirebaseFirestore _firebaseFirestore;

  UsersRepository({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async {
    try {
      // 1. Получаем "снимок" всей коллекции 'Users'
      final snapshot = await _firebaseFirestore.collection('users').get();

      final users = snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();

      return users;

    } catch (e) {
      // Если что-то пошло не так, выбрасываем исключение
      throw Exception('Ошибка при загрузке пользователей: $e');
    }
  }
}