import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/data/repository/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        if (profileProvider.isLoading) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.6,
                      width: double.infinity,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.lightBlueAccent
                          ], // Two colors
                          begin: Alignment.topLeft,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 22,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              size: 27,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 23),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6,
                      left: MediaQuery.of(context).size.width / 3.4,
                      child: profileProvider.image.isNotEmpty
                          ? CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.black,
                              child: Image.network(
                                profileProvider.image,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.broken_image,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : CircleAvatar(radius: 80, child: Icon(Icons.person)),
                    ),
                  ],
                ),
                Text(
                  '${profileProvider.firstName} ${profileProvider.lastName}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Username: ${profileProvider.username}',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Gender: ${profileProvider.gender}',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 25,
                          color: Colors.lightBlueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          profileProvider.email,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                profileProvider.logout(context);
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      size: 30,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "LogOut",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
