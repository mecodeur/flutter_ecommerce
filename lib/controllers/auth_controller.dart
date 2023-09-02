import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import 'package:flutter_ecommerce/utilities/constants.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';

import '../services/auth.dart';
import 'database_controller.dart';

class AuthController with ChangeNotifier {
  final AuthBase authBase;
  String email;
  String password;
  AuthFormType authFormType;

  // TODO: It's not a best practice thing but it's temporary
  final database = FirestoreDatabase('123');

  AuthController({
    required this.authBase,
    this.email = '',
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(
      email: '',
      password: '',
      authFormType: formType,
    );
  }

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await authBase.loginWithEmailAndPassword(email, password);
      } else {
        final user = await authBase.signUpWithEmailAndPassword(email, password);
        await database.setUserData(UserData(
          uid: user?.uid ?? documentIdFromLocalData(),
          email: email,
        ));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await authBase.logout();
    } catch (e) {
      rethrow;
    }
  }
}
