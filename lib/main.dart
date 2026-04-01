import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_s1ze/listener_screen.dart';
import 'package:screen_s1ze/overview_screen.dart';
import 'package:screen_s1ze/my_settings_screen.dart';
import 'package:screen_s1ze/theme/theme_cubit.dart';
import 'package:screen_s1ze/theme/theme_state.dart';
import 'package:screen_s1ze/widget/debug_change_banner_widget.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init(
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(
      // Disable console logging
      enable: false,
    ),
  ),
);

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showTalkerScreen(context),
          child: const Icon(Icons.document_scanner_outlined),
        ),
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          destinations: const [
            NavigationDestination(label: 'Screen Info', icon: Icon(Icons.home)),
            NavigationDestination(
              label: 'Listener Test',
              icon: Icon(Icons.touch_app),
            ),
            NavigationDestination(
              label: 'Setting',
              icon: Icon(Icons.settings),
            ),
          ],
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        ),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const OverviewScreen(),
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/listener',
            builder: (context, state) => const ListenerScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) => const MySettingsScreen(),
          ),
        ])
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DebugChangeBannerWidget(
      child: BlocProvider(
        create: (context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: state.themeData,
              routerConfig: _router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}

void _showTalkerScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TalkerScreen(talker: talker),
    ),
  );
}
