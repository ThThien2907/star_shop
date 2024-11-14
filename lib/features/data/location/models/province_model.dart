class ProvinceModel {
  final String nameWithType;
  final String code;
  final bool isDeleted;

  ProvinceModel({
    required this.nameWithType,
    required this.code,
    required this.isDeleted,
  });

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      nameWithType: map['name_with_type'],
      code: map['code'],
      isDeleted: map['isDeleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'name_with_type': nameWithType,
      'code': code,
      'isDeleted': isDeleted,
    };
  }
}
