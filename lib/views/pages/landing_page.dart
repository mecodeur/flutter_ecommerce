import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../services/auth.dart';
import 'auth_page.dart';
import 'bottom_navbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(authBase: auth),
              child: const AuthPage(),
            );
          }
          return ChangeNotifierProvider<AuthController>(
            create: (_) => AuthController(authBase: auth),
            child: Provider<Database>(
                create: (_) => FirestoreDatabase(user.uid),
                child: const BottomNavBar()),
          );
        }
        // TODO: We will refactor this to make one component for loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}