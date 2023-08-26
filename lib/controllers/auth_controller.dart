import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';

import '../services/auth.dart';

class AuthController with ChangeNotifier {
  final AuthBase authBase;
  String email;
  String password;
  AuthFormType authFormType;

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
        await authBase.signUpWithEmailAndPassword(email, password);
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
