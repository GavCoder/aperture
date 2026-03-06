import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

class ProfileEditingFields extends StatelessWidget {
  final String text;
  final String heading;
  final String toolTip;

  const ProfileEditingFields({
    super.key,
    required this.text,
    required this.toolTip,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Bio text container | We are going to change this into a text, so that the functionality of editing the bio can be added later on. And the buttonIcon will become th textfiled's suffixIcon.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 44),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                style: BorderStyle.none,
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ),

          // Edit icon button — bottom right corner
          Positioned(
            bottom: 4,
            right: 2,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
              color: Colors.grey[400],
              splashColor: AppColors.gradientOrange,
              tooltip: toolTip,
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Text(
              heading,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
