import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    final String? error = await UserRepository().signUp(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }
    await PreferencesManager().setBool("is_logged_in", true);

    setState(() {
      isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MainScreen();
        },
      ),
    );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('assets/images/logo.png', height: AppSizes.h45),
                    ),
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
                      title: 'User Name',
                      hintText: 'Mahmoud Refky',
                      controller: nameController,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Enter your name';
                        }

                        if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value)) {
                          return 'Enter valid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppSizes.h24),
                    CustomTextFormField(
                      title: 'Email',
                      hintText: 'refky@gmail.com',
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty || value.trim().isEmpty) {
                          return 'Enter your email';
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
                    if (errorMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.h16),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
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
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Sign Up'),
                      ),
                    ),
                    SizedBox(height: AppSizes.h24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account ?',
                          style: TextStyle(
                            fontSize: AppSizes.sp14,
                            color: Color(0xFF141414),
                          ),
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
