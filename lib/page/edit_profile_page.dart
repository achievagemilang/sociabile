import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/models/user.dart';
import 'package:sociabile/provider/auth_provider.dart';
import 'package:sociabile/services/auth_services.dart';
import 'package:sociabile/widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  _saveUser(BuildContext context, firstName, lastName, bio) async {
    await _authService.patchProfile(
        context: context, firstName: firstName, lastName: lastName, bio: bio);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthProvider>(context).user!;
    Widget buildSaveProfile() => InkWell(
          child: Text(
            "Save Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: GlobalVariables.purpleColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () {
            context.read<AuthProvider>().setUser(user);

            _saveUser(context, user.firstName, user.lastName, user.bio);

            // AuthProvider.setUser(user);
            Navigator.of(context).pop();
          },
        );

    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 5),
                  CircleAvatar(
                    radius: 82,
                    backgroundColor: GlobalVariables.purpleColor,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: user.photoUrl == null
                          ? const AssetImage("assets/RISTEK.png")
                              as ImageProvider
                          : NetworkImage(user.photoUrl!),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'First Name',
                text: user.firstName,
                onChanged: (value) => user = user.copy(firstName: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Last Name',
                text: user.lastName,
                onChanged: (value) => user = user.copy(lastName: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Bio',
                text: user.bio ?? "",
                onChanged: (value) => user = user.copy(bio: value),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: buildSaveProfile()),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
