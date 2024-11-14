class DistrictModel {
  final String nameWithType;
  final String code;
  final String parentCode;
  final bool isDeleted;

  DistrictModel({
    required this.nameWithType,
    required this.code,
    required this.parentCode,
    required this.isDeleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_with_type': nameWithType,
      'code': code,
      'parent_code': parentCode,
      'isDeleted': isDeleted,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      nameWithType: map['name_with_type'],
      code: map['code'],
      parentCode: map['parent_code'],
      isDeleted: map['isDeleted'],
    );
  }
}