import 'package:chat_app/2_application/core/services/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline1;
    return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: textStyle,
      ),
      actions: [
        Row(
          children: [
            const Icon(Icons.dark_mode),
            Switch(
                value: BlocProvider.of<ThemeCubit>(context).state,
                onChanged: (_) {
                  BlocProvider.of<ThemeCubit>(context, listen: false)
                      .toggleTheme();
                }),
            const Icon(Icons.light_mode),
            const SizedBox(width: 12),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
