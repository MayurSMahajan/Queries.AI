import 'package:chat_app/2_application/core/services/theme_cubit.dart';
import 'package:chat_app/2_application/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:chat_app/2_application/themes/theme.dart';
import 'injection.dart' as dependency_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  await dotenv.load(fileName: ".env");
  runApp(
    BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isLightTheme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: router,
        );
      },
    );
  }
}
