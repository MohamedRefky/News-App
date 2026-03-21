import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_state.dart';
import 'package:news_app/features/auth/repos/auth_repository.dart';
import 'package:news_app/features/main/main_screen.dart';

import 'cubit/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(ApiService())),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == RequestStatusEnum.loaded) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        },
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(AppSizes.r16),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: AppSizes.h45,
                              ),
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

                                if (!RegExp(
                                  r'^[a-zA-Z\u0600-\u06FF\s]+$',
                                ).hasMatch(value)) {
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
                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: AppSizes.h16),
                                child: Text(
                                  state.errorMessage!,
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
                                    context.read<AuthCubit>().register(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: state.status == RequestStatusEnum.loading
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
