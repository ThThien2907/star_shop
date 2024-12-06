class UserAddressEntity {
  String? addressId;
  String? addressName;
  String? detailedAddress;
  String? city;
  String? cityCode;
  String? district;
  String? districtCode;
  String? ward;
  bool? isDefault;

  UserAddressEntity({
    this.addressId,
    this.addressName,
    this.detailedAddress,
    this.city,
    this.cityCode,
    this.district,
    this.districtCode,
    this.ward,
    this.isDefault,
  });
}
