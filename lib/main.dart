import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_feed/core/constants.dart';
import 'package:social_feed/core/firebase_client.dart';
import 'package:social_feed/core/get_it.dart';
import 'package:social_feed/core/theme.dart';
import 'package:social_feed/features/feed/presentation/controllers/feeds_cubit.dart';

import 'core/routing.dart';
import 'core/shared_prefs.dart';
import 'features/feed/presentation/screens/feeds_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(hiveFeedCacheBox);
  await Hive.openBox(hiveProfileCacheBox);
  await Hive.box(hiveFeedCacheBox).clear();
  await Hive.box(hiveProfileCacheBox).clear();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs.init();
  setupDependencies();
  runApp(const SocialFeedApp());
  getIt<FeedsCubit>().getFeedsUseCase();
}

class SocialFeedApp extends StatelessWidget {
  const SocialFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Feed Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: (getIt<FirebaseClient>().firebaseAuth.currentUser != null) ? AppRouter.mainScreen : AppRouter.loginScreen,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    FeedsScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            _selectedIndex == 0 ? feedsTabName : profileTabName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  SizedBox buildBottomNavigationBar() {
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        selectedFontSize: 0,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppTheme.activeColor,
        unselectedItemColor: AppTheme.inActiveColor,
        type: BottomNavigationBarType.fixed,
        items: [
          buildBottomNavigationBarItem(
            activeIndex: _selectedIndex,
            itemIndex: 0,
            icon: Icons.feed,
            label: feedsTabName,
          ),
          buildBottomNavigationBarItem(
            activeIndex: _selectedIndex,
            itemIndex: 1,
            icon: Icons.person_2_outlined,
            label: profileTabName,
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem buildBottomNavigationBarItem({
  required int activeIndex,
  required int itemIndex,
  required IconData icon,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        if (activeIndex == itemIndex)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.activeColor,
              ),
            ),
          ),
      ],
    ),
    label: '',
  );
}
