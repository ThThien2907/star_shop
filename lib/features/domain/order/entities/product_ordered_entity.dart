class ProductOrderedEntity{
  final String productID;
  final String title;
  final num price;
  num totalPrice;
  final String images;
  num quantity;

  ProductOrderedEntity({
    required this.productID,
    required this.title,
    required this.price,
    required this.totalPrice,
    required this.images,
    required this.quantity,
  });
}