class CategoryModel {
  final String categoryID;
  final String image;
  final String title;

  CategoryModel({
    required this.categoryID,
    required this.image,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'categoryID': categoryID,
      'image': image,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryID: map['categoryID'],
      image: map['image'],
      title: map['title'],
    );
  }
}