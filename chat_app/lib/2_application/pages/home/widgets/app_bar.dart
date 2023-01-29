import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/theme_services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline1;
    return AppBar(
      elevation: 0,
      title: Text(
        "Ask Anything",
        style: textStyle,
      ),
      actions: [
        Row(
          children: [
            const Icon(Icons.light_mode),
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                }),
            const Icon(Icons.dark_mode),
            const SizedBox(width: 12),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
