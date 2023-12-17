import 'package:animations/animations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/core/shared/presentation/widgets/loader.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/screens/poems_feed_screen.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_drawer.dart';
import 'package:poetlum/features/saved_poems/presentation/screens/saved_poems_screen.dart';

class ScreensWrapper extends StatefulWidget {
  const ScreensWrapper({super.key});

  @override
  State<ScreensWrapper> createState() => _ScreensWrapperState();
}

class _ScreensWrapperState extends State<ScreensWrapper> {
  int screenIndex = 0;

  final screens = [
    const PoemsFeedScreen(),
    SavedPoemsScreen(getIt()),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(
      title: 'Poetlum',
    ),
    drawer: CustomDrawer(getIt()),
    body: FutureBuilder(
      future: FirebaseAnalytics.instance.setUserId(
        id: getIt<UserRepository>().getCurrentUser().userId,
      ),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Loader(text: 'Setting up analytics 🔎');
        } else{
          return PageTransitionSwitcher(
            child: screens[screenIndex],
            transitionBuilder: (
              child, 
              primaryAnimation, 
              secondaryAnimation,
            ) =>
              FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              ),
          );
        }
      },
    ),
    bottomNavigationBar: GNav(
      onTabChange: (value){
        FirebaseAnalytics.instance.logEvent(
          name: 'screen_navigation',
          parameters: {
            'screen_index': value,
          },
        );

        setState(() => screenIndex = value);
      },
      gap: 12,
      tabs: const [
        GButton(icon: Icons.home_outlined, text: 'Menu'),
        GButton(icon: Icons.bookmark_outline_rounded, text: 'Saved poems'),
      ],
    ),
  );
}
