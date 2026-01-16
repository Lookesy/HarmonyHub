import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:harmonyhubhest/features/users/user_model.dart';
import 'package:image_picker/image_picker.dart';

/// Репозиторий для управления данными профиля пользователя.
class UserProfileRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final ImagePicker _imagePicker;

  UserProfileRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    ImagePicker? imagePicker,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance,
        _imagePicker = imagePicker ?? ImagePicker();

  /// Получает полную модель [UserModel] для текущего авторизованного пользователя.
  Future<UserModel> fetchCurrentUserProfile() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован.');
    }
    try {
      final docSnapshot = await _firestore.collection('users').doc(user.uid).get();
      if (!docSnapshot.exists) {
        throw Exception('Данные пользователя не найдены в Firestore.');
      }
      return UserModel.fromMap(docSnapshot.data()!);
    } catch (e) {
      throw Exception('Ошибка при получении профиля пользователя: $e');
    }
  }

  /// Получает URL аватара для текущего пользователя.
  /// Возвращает пустую строку, если аватар не найден.
  Future<String> getAvatarUrl() async {
    final user = _firebaseAuth.currentUser;
    if (user == null || user.email == null) {
      return ''; // Нет пользователя - нет аватара.
    }
    try {
      // ВАЖНО: Используем email в пути, чтобы соответствовать старой логике.
      // В идеале лучше использовать user.uid, так как он не меняется.
      final url =
      await _storage.ref('users/${user.email}/Avatar.jpg').getDownloadURL();
      return url;
    } catch (e) {
      // Это нормальная ситуация, если аватар еще не был загружен.
      print('Аватар не найден: $e');
      return '';
    }
  }

  /// Запускает выбор изображения, загружает его как новый аватар
  /// и возвращает новый публичный URL.
  Future<String> uploadNewAvatar() async {
    final user = _firebaseAuth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('Пользователь не авторизован для загрузки аватара.');
    }

    // 1. Выбор изображения из галереи
    final XFile? imageFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85, // Слегка сжимаем для экономии места и трафика
    );

    if (imageFile == null) {
      // Пользователь отменил выбор файла
      throw Exception('Файл не выбран.');
    }

    // 2. Определяем путь в Storage
    final storageRef = _storage.ref('users/${user.email}/Avatar.jpg');

    // 3. Загружаем файл
    try {
      final uploadTask = await storageRef.putFile(File(imageFile.path));
      // После загрузки сразу получаем новый URL
      final newUrl = await uploadTask.ref.getDownloadURL();
      return newUrl;
    } on FirebaseException catch (e) {
      throw Exception('Ошибка загрузки файла в Firebase Storage: $e');
    } catch (e) {
      throw Exception('Неизвестная ошибка при загрузке аватара: $e');
    }
  }
}