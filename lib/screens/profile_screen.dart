import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/widgets/profile_editing_widget.dart';
import 'package:aperture/widgets/user_level_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: false,
        title: const Text(
          'Username',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.gradientPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: AppColors.gradientPurple,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      color: Colors.grey[200],
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const ProfileEditingFields(
              text:
                  'This is the user bio. It can be edited by clicking the edit icon at the bottom right corner of this container.\nThis is the user bio. It can be edited by clicking the edit icon at the bottom right corner of this container.',
              heading: 'Bio:',
              toolTip: 'Edit Bio',
            ),
            const SizedBox(height: 20),
            const ProfileEditingFields(
              text:
                  'This is the username. It can be edited by clicking the edit icon at the bottom right corner of this container.',
              heading: 'Username:',
              toolTip: 'Edit Username',
            ),
            const SizedBox(height: 20),
            const ProfileEditingFields(
              text:
                  'This is the email. It can be edited by clicking the edit icon at the bottom right corner of this container.',
              heading: 'Email:',
              toolTip: 'Edit Email',
            ),
            const SizedBox(height: 20),
            const ProfileEditingFields(
              text:
                  'This is the password. It can be edited by clicking the edit icon at the bottom right corner of this container.',
              heading: 'Password:',
              toolTip: 'Edit Password',
            ),
            const UserLevel(),
          ],
        ),
      ),
    );
  }
}