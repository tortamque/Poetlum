import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/data/repository/user_repository_impl.dart';
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

  final screens = const [
    PoemsFeedScreen(),
    SavedPoemsScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(
      title: 'Poetlum',
    ),
    drawer: CustomDrawer(UserRepositoryImpl(FirebaseAuth.instance)),
    body: screens[screenIndex],
    bottomNavigationBar: GNav(
      onTabChange: (value) => setState(() => screenIndex = value),
      gap: 12,
      tabs: const [
        GButton(icon: Icons.menu, text: 'Menu'),
        GButton(icon: Icons.bookmark_outline_rounded, text: 'Saved poems'),
      ],
    ),
  );
}
