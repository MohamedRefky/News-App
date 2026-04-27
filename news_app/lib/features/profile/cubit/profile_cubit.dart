import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/model/user_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void pickImage(ImageSource source) async {
    emit(state.copyWith(selectedImage: await ImagePicker().pickImage(source: source)));
  }

  void getUserData() {
    final UserModel? user = UserRepository().getUser();
    emit(
      state.copyWith(
        userName: user?.name ?? '',
        countryName: user?.countryName,
        countryCode: user?.countryCode,
        flagEmoji: user?.flagEmoji,
      ),
    );
  }

  void saveCountry(Country selectedCountry) async {
    UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
      flagEmoji: selectedCountry.flagEmoji,
    );
    emit(
      state.copyWith(
        countryName: selectedCountry.name,
        countryCode: selectedCountry.countryCode,
        flagEmoji: selectedCountry.flagEmoji,
      ),
    );
  }
}
