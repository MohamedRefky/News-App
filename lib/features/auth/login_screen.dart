import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

import 'cubit/auth_state.dart';
import 'repos/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(AuthRepository(ApiService())),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state.status == RequestStatusEnum.loaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const MainScreen();
                },
              ),
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
              builder: (BuildContext context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              title: 'Email',
                              hintText: 'refky@gmail.com',
                              controller: usernameController,
                              validator: (value) {
                                if (value.trim().isEmpty || value.trim().isEmpty) {
                                  return 'Enter email';
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
                                  return 'Enter password';
                                }
                              },
                            ),
                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: AppSizes.h8),
                                child: Text(
                                  state.errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            SizedBox(height: AppSizes.h24),
                            SizedBox(
                              width: double.infinity,
                              height: AppSizes.h48,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    context.read<AuthCubit>().login(
                                      usernameController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
                                child: state.status == RequestStatusEnum.loading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text('Sign In'),
                              ),
                            ),
                            SizedBox(height: AppSizes.h24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account ?',
                                  style: TextStyle(
                                    fontSize: AppSizes.sp14,
                                    color: Color(0xFF141414),
                                  ),
                                ),
                                SizedBox(width: AppSizes.w8),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
