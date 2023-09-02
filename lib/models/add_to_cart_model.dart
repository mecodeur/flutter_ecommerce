class AddToCartModel {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imgUrl;
  final int discountValue;
  final String color;
  final String size;

  AddToCartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    this.quantity = 1,
    required this.imgUrl,
    this.discountValue = 0,
    this.color = 'Black',
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'imgUrl': imgUrl,
      'discountValue': discountValue,
      'color': color,
      'size': size,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AddToCartModel(
      id: documentId,
      title: map['title'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      discountValue: map['discountValue']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
    );
  }
}
