import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../utilities/enums.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthBase>(context);

    return ChangeNotifierProvider<AuthController>(
      create: (_){
        return AuthController(authBase: auth);
      },
      /*create: (_)=> AuthController(authBase: auth),*/
      child: Consumer<AuthController>(
        builder: (_, model, __){
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 60.0,
                  horizontal: 32.0,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.authFormType == AuthFormType.login ? 'Login' : 'Register',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 80.0),
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          onChanged: model.updateEmail,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passwordFocusNode),
                          textInputAction: TextInputAction.next,
                          validator: (val) =>
                          val!.isEmpty ? 'Please enter your email' : null,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email!',
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: true,
                          onChanged: model.updatePassword,
                          validator: (val) =>
                          val!.isEmpty ? 'Please enter your password' : null,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password!',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            child: Text(model.authFormType == AuthFormType.login
                                ? 'Forgot your password?'
                                : ''),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: MainButton(
                            text: model.authFormType == AuthFormType.login
                                ? 'Login'
                                : 'Register',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _submit(model);
                                //model.submit();
                                //Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              model.toggleFormType();
                            },
                            child: Text(model.authFormType == AuthFormType.login
                                ? "Don\'t have an account? Register'"
                                : "Have an account? Login"),
                            //Text("Don\'t have an account? Register'"),
                          ),
                        ),
                        SizedBox(height: size.height * 0.09),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              model.authFormType == AuthFormType.login
                                  ? 'Or Login with'
                                  : 'Or Register with',
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.white,
                              ),
                              child: Icon(Icons.add),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submit(AuthController model) async{
    try {
      await model.submit();
      if(!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
    } catch (e) {
      // TODO: We will refactor this code into another widget in the next session
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Error!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            e.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
