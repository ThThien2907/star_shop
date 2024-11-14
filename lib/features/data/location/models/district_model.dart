class DistrictModel {
  final String name_with_type;
  final String code;
  final String parent_code;
  final bool isDeleted;

  DistrictModel({
    required this.name_with_type,
    required this.code,
    required this.parent_code,
    required this.isDeleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_with_type': name_with_type,
      'code': code,
      'parent_code': parent_code,
      'isDeleted': isDeleted,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      name_with_type: map['name_with_type'],
      code: map['code'],
      parent_code: map['parent_code'],
      isDeleted: map['isDeleted'],
    );
  }
}