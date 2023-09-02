import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';

import '../utilities/api_path.dart';

abstract class Database {
  Stream<List<Product>> newProductsStream();

  Stream<List<Product>> salesProductsStream();

  Future<void> setUserData(UserData userData);

  Future<void> addToCart(AddToCartModel product);

  Stream<List<AddToCartModel>> myProductCart(String uid);
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

  @override
  Future<void> setUserData(UserData userData) async {
    return await _service.setData(
      path: ApiPath.user(userData.uid),
      data: userData.toMap(),
    );
  }

  @override
  Future<void> addToCart(AddToCartModel product) async {
    return await _service.setData(
      path: ApiPath.addToCart(uid, product.id),
      data: product.toMap(),
    );
  }

  @override
  Stream<List<AddToCartModel>> myProductCart(String uid) {
    return _service.collectionsStream(
      path: ApiPath.myProductsCart(uid),
      builder: (data, documentId) => AddToCartModel.fromMap(data!, documentId) ,
    );
  }
}
