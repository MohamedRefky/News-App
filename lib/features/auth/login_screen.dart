import 'package:flutter/material.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  String? errorMassage;
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
      errorMassage = null;
    });
    await Future.delayed(const Duration(seconds: 3));
    final savedEmail = PreferencesManager().getString('user_email');
    final savedPassword = PreferencesManager().getString('user_password');

    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMassage = 'You don\'t have an account register first';
        isLoading = false;
      });
      return;
    }
    if (savedEmail != emailController.text.trim()) {
      setState(() {
        errorMassage = 'Invalid Email';
        isLoading = false;
      });
      return;
    }

    if (savedPassword != passwordController.text.trim()) {
      setState(() {
        errorMassage = 'Invalid Password';
        isLoading = false;
      });
      return;
    }

    await PreferencesManager().setBool('is_logged_in', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
    setState(() {
      isLoading = false;
      errorMassage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 45),
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome to Newts',
                  style: TextStyle(
                    color: Color(0xFF363636),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24),
                CustomTextFormField(
                  title: 'Email',
                  hintText: 'refky@gmail.com',
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty || value.trim().isEmpty) {
                      return 'Enter email';
                    }
                    RegExp emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomTextFormField(
                  title: 'Password',
                  hintText: '*************',
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.trim().isEmpty) {
                      return 'Enter password';
                    }
                  },
                ),
                if (errorMassage != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      errorMassage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text('Sign In'),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account ?',
                      style: TextStyle(fontSize: 14, color: Color(0xFF141414)),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
