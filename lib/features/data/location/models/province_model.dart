class ProvinceModel {
  final String name_with_type;
  final String code;
  final bool isDeleted;

  ProvinceModel({
    required this.name_with_type,
    required this.code,
    required this.isDeleted,
  });

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      name_with_type: map['name_with_type'],
      code: map['code'],
      isDeleted: map['isDeleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'name_with_type': name_with_type,
      'code': code,
      'isDeleted': isDeleted,
    };
  }
}
