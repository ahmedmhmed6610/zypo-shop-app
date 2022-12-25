import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit() : super(PersonalDataInitial());
  static PersonalDataCubit get(BuildContext context) =>
      BlocProvider.of(context);


  final ImagePicker _picker = ImagePicker();
  File? profilePicture;
  bool showPassword = true;


  changeProfilePicture() async {
    XFile? _image = await _picker.pickImage(source: ImageSource.gallery);

    profilePicture = File(_image!.path);

    emit(ChangeProfilePictureState());
  }

  togglePassword() {
    showPassword = !showPassword;
    emit(TogglePasswordState());
  }
}
