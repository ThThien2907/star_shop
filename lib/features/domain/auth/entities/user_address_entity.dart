class UserAddressEntity {
  final String addressId;
  final String addressName;
  final String detailedAddress;
  final String city;
  final String district;
  final String ward;
  final bool isDefault;

  UserAddressEntity({
    required this.addressId,
    required this.addressName,
    required this.detailedAddress,
    required this.city,
    required this.district,
    required this.ward,
    required this.isDefault,
  });

  @override
  String toString() {
    return 'UserAddressEntity{addressId: $addressId, addressName: $addressName, detailedAddress: $detailedAddress, city: $city, district: $district, ward: $ward, isDefault: $isDefault}';
  }
}
