import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_ui_state.dart';

class AppUiCubit extends Cubit<AppUiState> {
  AppUiCubit() : super(AppUiInitial());
  static AppUiCubit get(BuildContext context) => BlocProvider.of(context);
  bool isGrid = false;

  toggleView() {
    isGrid = !isGrid;
    emit(ToggleUIState());
  }

}
