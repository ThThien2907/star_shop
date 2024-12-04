class UserAddressModel {
  final String addressId;
  final String addressName;
  final String detailedAddress;
  final String city;
  final String district;
  final String ward;
  final bool isDefault;

  UserAddressModel({
    required this.addressId,
    required this.addressName,
    required this.detailedAddress,
    required this.city,
    required this.district,
    required this.ward,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'addressId': addressId,
      'addressName': addressName,
      'detailedAddress': detailedAddress,
      'city': city,
      'district': district,
      'ward': ward,
      'isDefault': isDefault,
    };
  }

  factory UserAddressModel.fromMap( Map<String, dynamic> map) {
    return UserAddressModel(
      addressId: map['addressId'],
      addressName: map['addressName'],
      detailedAddress: map['detailedAddress'],
      city: map['city'],
      district: map['district'],
      ward: map['ward'],
      isDefault: map['isDefault'],
    );
  }
}
