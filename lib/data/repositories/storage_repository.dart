import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageRepository {
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  StorageRepository({
    FirebaseStorage? storage,
    FirebaseAuth? auth,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Загружает файл аватара в Firebase Storage.
  ///
  /// [file] - Файл для загрузки.
  /// Возвращает URL загруженного файла.
  Future<String> uploadAvatar(File file) async {
    final userEmail = _auth.currentUser?.email;
    if (userEmail == null) {
      throw Exception("Пользователь не авторизован.");
    }

    final ref = _storage.ref('users/$userEmail/Avatar.jpg');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }

  /// Получает URL аватара пользователя по его email.
  ///
  /// [userEmail] - Email пользователя.
  /// Возвращает URL аватара или пустую строку, если аватар не найден.
  Future<String> getUserAvatarUrl(String userEmail) async {
    try {
      final ref = _storage.ref('users/$userEmail/Avatar.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      // Если файл не найден, это не ошибка, просто возвращаем пустую строку
      if (e.code == 'object-not-found') {
        return '';
      }
      // Другие ошибки Firebase Storage пробрасываем дальше
      rethrow;
    }
  }
}
