import 'package:flutter/material.dart';
import 'package:testing_app/data/services/local_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing_app/pages/login_page.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String _username = "";
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  String _image = "";

  bool get isLoading => _isLoading;
  String get username => _username;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get image => _image;

  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();
    try {
      var userData = await LocalService().getUserData();
      _username = userData['username']!;
      _email = userData['email']!;
      _firstName = userData['firstName']!;
      _lastName = userData['lastName']!;
      _gender = userData['gender']!;
      _image = userData['image']!;
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await LocalService().logout();
    // Navigate back to the login screen
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
