import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.overlayDark.withOpacity(0.05),
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
              height: 50,
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
            const SizedBox(height: 25),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Bio goes here',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.grey[200],
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
