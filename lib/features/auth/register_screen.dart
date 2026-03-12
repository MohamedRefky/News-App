import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? errorMassage;
  bool isLoading = false;

  void register() async {
    setState(() {
      isLoading = true;
      errorMassage = null;
    });
    await Future.delayed(const Duration(seconds: 3));
    final savedEmail = PreferencesManager().getString('user_email');

    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMassage = 'User Already Registered';
        isLoading = false;
      });
    } else {
      await PreferencesManager().setString('user_email', emailController.text);
      await PreferencesManager().setString('user_password', passwordController.text);
      await PreferencesManager().setBool('is_logged_in', true);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
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
          padding: EdgeInsets.all(AppSizes.r16),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset('assets/images/logo.png', height: AppSizes.h45)),
                    SizedBox(height: AppSizes.h24),
                    Text(
                      'Welcome to Newts',
                      style: TextStyle(
                        color: Color(0xFF363636),
                        fontSize: AppSizes.sp20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppSizes.h24),
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
                    SizedBox(height: AppSizes.h24),
                    CustomTextFormField(
                      title: 'Password',
                      hintText: '*************',
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.trim().isEmpty) {
                          return 'Confirm your password';
                        }

                        return null;
                      },
                    ),
                    if (errorMassage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.h16),
                        child: Text(errorMassage!, style: const TextStyle(color: Colors.red)),
                      ),
                    SizedBox(height: AppSizes.h24),
                    CustomTextFormField(
                      title: 'Confirm Passward',
                      hintText: '*************',
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value.isEmpty || value.trim().isEmpty) {
                          return 'Enter password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords Not match';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: AppSizes.h24),
                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.h48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            register();
                          }
                        },
                        child: isLoading ? const CircularProgressIndicator() : Text('Sign Up'),
                      ),
                    ),
                    SizedBox(height: AppSizes.h24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account ?',
                          style: TextStyle(fontSize: AppSizes.sp14, color: Color(0xFF141414)),
                        ),
                        SizedBox(width: AppSizes.w8),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
