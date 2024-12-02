class ProductOrderedEntity{
  final String productID;
  final String title;
  final num price;
  final num oldPrice;
  num totalPrice;
  final String images;
  final num quantityInStock;
  num quantity;

  ProductOrderedEntity({
    required this.productID,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.totalPrice,
    required this.images,
    required this.quantityInStock,
    required this.quantity,
  });
}