import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alterra/auth/login_auth.dart';
import 'package:mini_project_alterra/screen/about_screen.dart';
import 'package:mini_project_alterra/screen/review_screen.dart';
import 'package:mini_project_alterra/screen/watchlist_screen.dart';
import 'package:mini_project_alterra/widgets/custom_dialog.dart';

class DrawerCard extends StatefulWidget {
  const DrawerCard({super.key});

  @override
  State<DrawerCard> createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  final _auth = FirebaseAuth.instance;
  late User _activeUser;

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  void _getCurrentUser() {
    try {
      var currentUser = _auth.currentUser;

      if (currentUser != null) {
        _activeUser = currentUser;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2017/02/13/01/26/the-question-mark-2061539_1280.png'),
            ),
            accountName: Text(_activeUser.displayName!),
            accountEmail: Text(_activeUser.email!),
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Scheduling Movie'),
            onTap: () {
              customDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens_outlined),
            title: const Text('Dark Theme'),
            onTap: () {
              customDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt_sharp),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMovieScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Review App'),
            onTap: () {
              Navigator.pushNamed(context, ReviewListScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pushNamed(context, AboutScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              await _auth.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginAuth.routeName, (route) => false));
            },
          ),
        ],
      ),
    );
  }
}
