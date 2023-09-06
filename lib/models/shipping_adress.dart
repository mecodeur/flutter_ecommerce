class ShippingAdress {
  final String id;
  final String fullName;
  final String country;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  ShippingAdress({
    required this.id,
    required this.fullName,
    required this.country,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'country': country,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'isDefault': isDefault,
    };
  }

  factory ShippingAdress.fromMap(Map<String, dynamic> map, String documentId) {
    return ShippingAdress(
      id: documentId,
      fullName: map['fullName'] as String,
      country: map['country'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      zipCode: map['zipCode'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }
}
