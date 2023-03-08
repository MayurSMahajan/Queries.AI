import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true);

  //toggle the theme.
  void toggleTheme() => emit(!state);
}
