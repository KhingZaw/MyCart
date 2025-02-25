import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', accessToken);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', userData['username']);
    pref.setString('email', userData['email']);
    pref.setString('firstName', userData['firstName']);
    pref.setString('lastName', userData['lastName']);
    pref.setString('gender', userData['gender']);
    pref.setString('image', userData['image']);
  }

  Future<Map<String, String>> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String username = pref.getString('username') ?? '';
    String email = pref.getString('email') ?? '';
    String firstName = pref.getString('firstName') ?? '';
    String lastName = pref.getString('lastName') ?? '';
    String gender = pref.getString('gender') ?? '';
    String image = pref.getString('image') ?? '';
    return {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
    };
  }

  Future<String?> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('accessToken');
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('accessToken');
    await pref.remove('username');
    await pref.remove('email');
    await pref.remove('firstName');
    await pref.remove('lastName');
    await pref.remove('gender');
    await pref.remove('image');
  }
}
