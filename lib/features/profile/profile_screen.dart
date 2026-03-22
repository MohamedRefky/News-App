import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/themes/light_color.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:news_app/features/profile/custom_list_tile.dart';

import 'bottom sheet/profile_bottom_sheet.dart';
import 'cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.h20, horizontal: AppSizes.w16),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (BuildContext context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: AppSizes.r70,
                            backgroundImage: state.selectedImage == null
                                ? AssetImage('assets/images/person.png') as ImageProvider
                                : FileImage(File(state.selectedImage!.path)),
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
                              child: Icon(
                                Icons.photo_camera_outlined,
                                size: AppSizes.r26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.h8),
                    Text(
                      state.userName ?? '',
                      style: TextStyle(color: Color(0xFF161F1B), fontSize: 16),
                    ),
                    SizedBox(height: AppSizes.h16),
                    CustomListTile(
                      title: 'Personal Info',
                      leading: SvgPicture.asset('assets/images/Person_Icon.svg'),
                      onTap: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => ProfileBottomSheet(),
                        ).then((value) {
                          context.read<ProfileCubit>().getUserData();
                        });
                      },
                    ),
                    CustomListTile(
                      title: 'Language',
                      leading: SvgPicture.asset('assets/images/Language_Icon.svg'),
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: state.countryName ?? 'Country',
                      leading: state.flagEmoji != null
                          ? Text(state.flagEmoji!, style: TextStyle(fontSize: 24))
                          : SvgPicture.asset('assets/images/flag_icon.svg'),
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (Country selectedCountry) {
                            context.read<ProfileCubit>().saveCountry(selectedCountry);
                          },
                        );
                      },
                    ),
                    CustomListTile(
                      title: 'Terms & Conditions',
                      leading: SvgPicture.asset(
                        'assets/images/terms_conditions_Icon.svg',
                      ),
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: 'Logout',
                      textColor: LightColor.primaryColor,
                      leading: SvgPicture.asset('assets/images/logout_Icon.svg'),
                      trailingColor: LightColor.primaryColor,
                      onTap: () async {
                        await PreferencesManager().clear();
                        await UserRepository().delete();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      withDivider: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void showImageSorceDialog(BuildContext context) {
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
              context.read<ProfileCubit>().pickImage(ImageSource.camera);
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
              context.read<ProfileCubit>().pickImage(ImageSource.gallery);
            },
          ),
        ],
      );
    },
  );
}
