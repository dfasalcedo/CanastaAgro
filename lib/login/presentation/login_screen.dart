import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../navigation_drawer/presentation/navigation_screen.dart';
import 'sing_up_screen.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final auth = FirebaseAuth.instance;

    Future<void> login() async {
      if (formKey.currentState?.validate() != true) {
        return;
      }
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        emailController.clear();
        passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavigationScreen()),
        );
      } catch (e) {
        String errorMessage;
        switch (e.hashCode) {
          case 'user-not-found':
            errorMessage = 'Usuario no encontrado';
            break;
          case 'wrong-password':
            errorMessage = 'Contraseña incorrecta';
            break;
          default:
            errorMessage = 'Ocurrió un error. Inténtalo de nuevo';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 100),
                const SizedBox(height: 48.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo Email no puede estar vacío';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Ingresa un Email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo Password no puede estar vacío';
                    }
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: login,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}