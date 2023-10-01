// ignore_for_file: unnecessary_null_comparison, prefer_null_aware_operators

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? bio;
  final String? photoUrl;
  final String? photoPublicId;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.bio,
    this.photoUrl,
    this.photoPublicId,
    required this.createdAt,
    required this.updatedAt,
  });

  User copy({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? bio,
    String? photoUrl,
    String? photoPublicId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        bio: bio ?? this.bio,
        photoUrl: photoUrl ?? this.photoUrl,
        photoPublicId: photoPublicId ?? this.photoPublicId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      bio: json['bio'],
      photoUrl: json['photoUrl'],
      photoPublicId: json['photoPublicId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
      'bio': bio,
      'photoUrl': photoUrl,
      'photoPublicId': photoPublicId,
      'createdAt': createdAt == null ? null : createdAt.toIso8601String(),
      'updatedAt': updatedAt == null ? null : updatedAt.toIso8601String(),
    };
  }
}
