import 'package:flutter/material.dart';
import 'package:mini_project_alterra/screen/watchlist_screen.dart';
import 'package:mini_project_alterra/widgets/custom_dialog.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1665724627267-ceb4e03202c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80'),
            ),
            accountName: Text('Baby'),
            accountEmail: Text('Baby@gmail.com'),
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
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              customDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
