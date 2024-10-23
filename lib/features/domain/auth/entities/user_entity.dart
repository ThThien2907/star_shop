class UserEntity {
  final String userId;
  final String fullName;
  final String email;
  final DateTime dob;
  final String phoneNumber;
  final String address;
  final int gender;

  UserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.address,
    required this.gender,
  });
}
