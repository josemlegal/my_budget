import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
  });

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      name: data!["name"],
      email: data["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };

  UserModel copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }
}
