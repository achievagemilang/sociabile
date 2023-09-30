class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? birthDate;
  final String? photoUrl;
  final String? photoPublicId;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.birthDate,
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
    String? birthDate,
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
        birthDate: birthDate ?? this.birthDate,
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
      birthDate: json['birthDate'],
      photoUrl: json['photoUrl'],
      photoPublicId: json['photoPublicId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
