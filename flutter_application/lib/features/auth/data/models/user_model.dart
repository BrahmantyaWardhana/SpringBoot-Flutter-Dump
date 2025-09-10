import 'package:flutter_application/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.username, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
