class ProductOrderedModel {
  final String productID;
  final String title;
  final num price;
  final num oldPrice;
  final num totalPrice;
  final String images;
  final num quantityInStock;
  final num quantity;

  ProductOrderedModel({
    required this.productID,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.totalPrice,
    required this.images,
    required this.quantityInStock,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'title': title,
      'price': price,
      'oldPrice': oldPrice,
      'totalPrice': totalPrice,
      'images': images,
      'quantityInStock': quantityInStock,
      'quantity': quantity,
    };
  }

  factory ProductOrderedModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderedModel(
      productID: map['productID'],
      title: map['title'],
      price: map['price'],
      oldPrice:map['oldPrice'],
      totalPrice:map['totalPrice'],
      images: map['images'],
      quantityInStock:map['quantityInStock'],
      quantity:map['quantity'],
    );
  }


}
