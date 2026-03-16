import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/model/user_mdel.dart';
import 'package:news_app/core/themes/light_color.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loudeUserData();
  }

  void _loudeUserData() {
    final UseerModel? user = UserRepository().getUser();
    emailController.text = user?.email ?? '';
    nameController.text = user?.name ?? '';
  }

  void _saveUserData() async {
    if (formKey.currentState?.validate() ?? false)  {
       UserRepository().updateUser(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height:
            MediaQuery.of(context).size.height * .50 +
            MediaQuery.of(context).viewInsets.bottom,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightColor.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.r16),
            topRight: Radius.circular(AppSizes.r16),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.w16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: AppSizes.h4,
                      width: AppSizes.w32,
                      decoration: BoxDecoration(
                        color: Color(0xFF363636),
                        borderRadius: BorderRadius.circular(AppSizes.r100),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.h24),
                  Text(
                    'Profile Info',
                    style: TextStyle(fontSize: AppSizes.sp16, color: Color(0xFF141414)),
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomTextFormField(
                    title: 'User Name',
                    hintText: PreferencesManager().getString('user_name') ?? '',
                    controller: nameController,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Enter your name';
                      }

                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Enter valid name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomTextFormField(
                    title: 'Email',
                    hintText: PreferencesManager().getString('user_email') ?? '',
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
                  ElevatedButton(
                    onPressed: () {
                      _saveUserData();
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
