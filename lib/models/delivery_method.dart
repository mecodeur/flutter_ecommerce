class DeliveryMethod {
  final String id;
  final String name;
  final String days;
  final String imgUrl;
  final double price;

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.days,
    required this.imgUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'days': days,
      'imgUrl': imgUrl,
      'price': price,
    };
  }

  factory DeliveryMethod.fromMap(Map<String, dynamic> map, documentId) {
    return DeliveryMethod(
      id: documentId as String,
      name: map['name'] as String,
      days: map['days'] as String,
      imgUrl: map['imgUrl'] as String,
      price: map['price'].toDouble(),
    );
  }
}
