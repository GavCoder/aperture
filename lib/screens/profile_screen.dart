import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/widgets/app_button.dart';
import 'package:aperture/widgets/blobs.dart';
import 'package:aperture/widgets/profile_editing_widget.dart';
import 'package:aperture/widgets/user_level_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Blobs(
            blobPath: 'assets/blobs/blob1.svg',
            svgWidth: 490,
            topPosition: -260,
            leftPosition: -50,
          ),
          const Blobs(
            blobPath: 'assets/blobs/blob2.svg',
            svgWidth: 490,
            topPosition: 650,
            leftPosition: -250,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Cynthia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gradientOrange,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 100,
                            backgroundColor: AppColors.gradientPurple,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1772615071604-f06863d231fd?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw5OXx8fGVufDB8fHx8fA%3D%3D',
                            ),
                          ),
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
                  const SizedBox(height: 20),
                  AppButton(
                    btnColor: AppColors.gradientPurple,
                    btnText: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.save_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
