class UserEntity {
  final String userId;
  final String fullName;
  final String email;
  final String dob;
  final String phoneNumber;
  final String address;
  final String city;
  final String district;
  final String ward;
  final String gender;
  final String role;

  UserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.district,
    required this.ward,
    required this.gender,
    required this.role,
  });

  @override
  String toString() {
    return 'UserEntity{userId: $userId, fullName: $fullName, email: $email, dob: $dob, phoneNumber: $phoneNumber, address: $address, city: $city, district: $district, ward: $ward, gender: $gender, role: $role}';
  }
}
