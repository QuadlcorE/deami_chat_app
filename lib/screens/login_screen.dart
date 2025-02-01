import 'package:deami_chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _loginWithEmailAndPassword(context) async {
    if (_formKey.currentState!.validate()) {
      // Perform email and password login logic here
      // Auth service
      final authService = AuthServices();

      // Try login
      try {
        await authService.signInWithEmailPassword(
            _emailController.text, _passwordController.text);
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      }

      // Catch any errors
      catch (e) {
        // Extract the error message from the exception
        String errorMessage = 'An unexpected error occurred. Please try again.';
        if (e is String ) {
          errorMessage = e;
        }
        else if (e is Exception) {
          errorMessage = e.toString().replaceFirst('Exception: ', ''); // Remove "Exception: " prefix
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      // print('Logging in with email: ${_emailController.text}');
    }
    // Navigator.pushNamed(context, "/home");
  }

  void _loginWithGoogle() {
    // Add your Google login logic here
    // print('Logging in with Google');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TODO: Fix the visual difference between layout of login and registration.

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),

                            // Title
                            Text(
                              'Login',
                              style: Theme.of(context).textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // Email TextField
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Password TextField
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            const Spacer(),

                            // Login Button
                            ElevatedButton(
                              onPressed: () =>
                                  _loginWithEmailAndPassword(context),
                              child: const Text('Login with Email'),
                            ),
                            const SizedBox(height: 10),

                            // TODO: Add Google login functionality
                            // Google Login Button
                            // OutlinedButton.icon(
                            //   onPressed: _loginWithGoogle,
                            //   icon: const Icon(Icons.g_mobiledata, size: 32),
                            //   label: const Text('Login with Google'),
                            // ),
                            // const SizedBox(height: 20),

                            // Register Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        '/registration', (route) => false);
                                  },
                                  child: const Text('Register'),
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
        ),
      ),
    );
  }
}
