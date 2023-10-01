import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/models/user.dart';
import 'package:sociabile/page/main_page.dart';
import 'package:sociabile/provider/auth_provider.dart';
import 'package:sociabile/widgets/ribbon_description.dart';

import '../widgets/ribbon_heading.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthProvider>(context).user!;
    Widget buildEditProfile() => InkWell(
          child: Text(
            "Edit Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: GlobalVariables.purpleColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () async {
            // await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>  EditProfilePage(),
            //   ),
            // );
            setState(() {});
          },
        );

    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 5),
                  CircleAvatar(
                    radius: 82,
                    backgroundColor: GlobalVariables.purpleColor,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: user.photoUrl == null
                          ? AssetImage("assets/RISTEK.png") as ImageProvider
                          : NetworkImage(user.photoUrl!),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: GlobalVariables.purpleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "RISTEK 2023",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 186, 186, 186),
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            RibbonHeading(text: 'First Name'),
            RibbonDescription(text: user.firstName),
            RibbonHeading(text: 'Last Name'),
            RibbonDescription(text: user.lastName),
            RibbonHeading(text: 'Email'),
            RibbonDescription(text: user.email),
            RibbonHeading(text: 'Bio'),
            RibbonDescription(text: user.bio ?? ""),
            SizedBox(height: 20),
            // Center(
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 20),
            //     child: Align(
            //         alignment: Alignment.bottomCenter,
            //         child: buildEditProfile()),
            //   ),
            // ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
