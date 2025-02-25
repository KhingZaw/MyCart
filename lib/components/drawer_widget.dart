import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/components/drawer_tile_widget.dart';
import 'package:testing_app/data/repository/profile_provider.dart';
import 'package:testing_app/pages/login_page.dart';
import 'package:testing_app/pages/profile_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
          ),
          Center(
            child: Text(
              "Flutter App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(
              color: Colors.grey.shade400,
            ),
          ),
          //home list title
          DrawerTileWidget(
            text: "H O M E",
            onTap: () => Navigator.pop(context),
            icon: Icons.home,
          ),
          //profile screen
          DrawerTileWidget(
            text: "P R O F I L E",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: Icons.person,
          ),
          const Spacer(),
          DrawerTileWidget(
            text: "L O G O U T",
            onTap: () {
              profileProvider.logout(context);
              // Navigate back to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icons.logout,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
