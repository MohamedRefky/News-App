import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.selectedImage,
    this.userName,
    this.countryName,
    this.countryCode,
    this.flagEmoji,
  });
  final XFile? selectedImage;
  final String? userName;
  final String? countryName;
  final String? countryCode;
  final String? flagEmoji;

  ProfileState copyWith({
    XFile? selectedImage,
    String? userName,
    String? countryName,
    String? countryCode,
    String? flagEmoji,
  }) => ProfileState(
    selectedImage: selectedImage ?? this.selectedImage,
    userName: userName ?? this.userName,
    countryName: countryName ?? this.countryName,
    countryCode: countryCode ?? this.countryCode,
    flagEmoji: flagEmoji ?? this.flagEmoji,
  );
  
  @override
  List<Object?> get props => [
    selectedImage,
    userName,
    countryName,
    countryCode,
    flagEmoji,
  ];
}

final class ProfileInitial extends ProfileState {}
