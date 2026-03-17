import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/model/user_model.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;
  String? userName;
  String? countryName;
  String? countryCode;
  String? flagEmoji;
  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  void getUserData() {
    final UseerModel? user = UserRepository().getUser();
    userName = user?.name ?? '';
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    flagEmoji = user?.flagEmoji;
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
      flagEmoji: selectedCountry.flagEmoji,
    );
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    flagEmoji = selectedCountry.flagEmoji;

    safeNotify();
  }
}
