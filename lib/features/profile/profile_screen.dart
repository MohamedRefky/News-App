import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/features/profile/coustom_list_tile.dart';
import 'package:provider/provider.dart';

import 'controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.h20, horizontal: AppSizes.w16),
          child: Consumer<ProfileController>(
            builder: (BuildContext context, ProfileController controller, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: AppSizes.r70,
                          backgroundImage: controller.selectedImage == null
                              ? AssetImage('assets/images/person.png') as ImageProvider
                              : FileImage(File(controller.selectedImage!.path)),
                        ),
                        GestureDetector(
                          onTap: () async {
                            showImageSorceDialog(context);
                          },
                          child: Container(
                            height: AppSizes.h40,
                            width: AppSizes.w40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.r100),
                              color: Colors.white,
                            ),
                            child: Icon(Icons.photo_camera_outlined, size: AppSizes.r26),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text("Mohame Refky", style: TextStyle(color: Color(0xFF161F1B), fontSize: 16)),
                  SizedBox(height: AppSizes.h16),
                 
                  CoustomListtile(title: 'Personal Info', leading: 'assets/images/Person_Icon.svg'),
                  CoustomListtile(title: 'Language', leading: 'assets/images/Language_Icon.svg'),
                  CoustomListtile(title: 'Country', leading: 'assets/images/flag_icon.svg'),
                  CoustomListtile(
                    title: 'Terms & Conditions',
                    leading: 'assets/images/terms_conditions_Icon.svg',
                  ),
                  CoustomListtile(
                    title: 'Logout',
                    textColor: Color(0xFFC53030),
                    leading: 'assets/images/logout_Icon.svg',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void showImageSorceDialog(BuildContext context) {
  final controller = context.read<ProfileController>();
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text('Choose Image Source', style: TextTheme.of(context).titleMedium),
        children: [
          SimpleDialogOption(
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(width: AppSizes.w10),
                Text('Camera'),
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
          ),
          SimpleDialogOption(
            child: Row(
              children: [
                Icon(Icons.photo_library_outlined),
                SizedBox(width: AppSizes.w10),
                Text('Gallery'),
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
          ),
        ],
      );
    },
  );
}
