import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';

import '../utilities/api_path.dart';

abstract class Database {
  Stream<List<Product>> newProductsStream();

  Stream<List<Product>> salesProductsStream();

  /*Future<void> setData();*/
}

class FirestoreDatabase implements Database {
  final _service = FirestoreServices.instance;

  final String uid;

  FirestoreDatabase(this.uid);

  @override
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );

  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  /*
  @override
  Future<void> setProduct(Product product) async {
    return _service.setData(
        path: ApiPath.products(),
        data: product.toMap());
  }*/

}
