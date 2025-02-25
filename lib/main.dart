import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_app/data/repository/auth_provider.dart';
import 'package:testing_app/data/repository/cart_provider.dart';
import 'package:testing_app/data/repository/profile_provider.dart';
import 'package:testing_app/pages/home_page.dart';
import 'package:testing_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token;
  try {
    token = pref.getString('accessToken');
  } catch (e) {
    token = null;
    // Handle error, if needed
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MyApp(token: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});
  @override
  Widget build(BuildContext context) {
    // Automatically load user data if the user is logged in
    if (token != null) {
      // Trigger loading of user data in ProfileProvider
      Future.microtask(() {
        final profileProvider =
            Provider.of<ProfileProvider>(context, listen: false);
        if (profileProvider.username.isEmpty) {
          profileProvider.loadUserData();
        }
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testing App',
      home: token == null ? LoginPage() : HomePage(),
    );
  }
}
