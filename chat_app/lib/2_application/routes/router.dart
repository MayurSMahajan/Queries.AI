import 'package:chat_app/2_application/pages/create_flashcard/create_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home/home.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreenWrapper();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          name: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreenWrapper();
          },
        ),
        GoRoute(
          path: 'create_flashcard/:message',
          name: 'create_flashcard',
          builder: (BuildContext context, GoRouterState state) {
            return CreateFlashcard(
              message: state.params['message'],
            );
          },
        ),
      ],
    ),
  ],
);
