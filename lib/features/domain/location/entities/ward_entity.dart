class WardEntity {
  final String name_with_type;
  final String code;
  final String parent_code;
  final bool isDeleted;

  WardEntity({
    required this.name_with_type,
    required this.code,
    required this.parent_code,
    required this.isDeleted,
  });
}