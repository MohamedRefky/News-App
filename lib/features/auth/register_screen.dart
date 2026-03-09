import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png', height: 45)),
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
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                title: 'Password',
                hintText: '*************',
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                title: 'Confirm Passward',
                hintText: '*************',
                controller: confirmPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account ?',
                    style: TextStyle(fontSize: 14, color: Color(0xFF141414)),
                  ),
                  SizedBox(width: 8),
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
    );
  }
}
