import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;
  String? userName;
  String? countryName;
  String? countryCode;
String ? flagEmoji;
  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  void getUserData() {
    userName = PreferencesManager().getString('user_name');
    countryName = PreferencesManager().getString('country_name');
    countryCode = PreferencesManager().getString('country_code');
    flagEmoji = PreferencesManager().getString('flag_emoji');
    safeNotify();
  }

  void saveCountry(Country selectedCountry, ) async {
    await PreferencesManager().setString('country_name', selectedCountry.name);
    await PreferencesManager().setString('country_code', selectedCountry.countryCode);
    await PreferencesManager().setString('flag_emoji', selectedCountry.flagEmoji);
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    flagEmoji = selectedCountry.flagEmoji;

    safeNotify();
  }
}
