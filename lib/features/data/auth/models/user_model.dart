class UserModel {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? dob;
  final String? phoneNumber;
  final String? gender;
  final String? role;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      dob: map['dob'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
    );
  }
}
