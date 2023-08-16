import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
    required this.id,
  });

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return User(
      id: document.id,
      name: data!["name"],
      email: data["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };

  User copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return User(
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
