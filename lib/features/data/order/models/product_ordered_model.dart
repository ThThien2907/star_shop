class ProductOrderedModel {
  final String productID;
  final String title;
  final num price;
  final num totalPrice;
  final String images;
  final num quantity;

  ProductOrderedModel({
    required this.productID,
    required this.title,
    required this.price,
    required this.totalPrice,
    required this.images,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'title': title,
      'price': price,
      'totalPrice': totalPrice,
      'images': images,
      'quantity': quantity,
    };
  }

  factory ProductOrderedModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderedModel(
      productID: map['productID'],
      title: map['title'],
      price: map['price'],
      totalPrice:map['totalPrice'],
      images: map['images'],
      quantity:map['quantity'],
    );
  }


}
