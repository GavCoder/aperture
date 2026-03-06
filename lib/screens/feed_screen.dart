import 'dart:ui';

import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      // Removed SafeArea to allow background blobs to extend to edges of screen
      body: Stack(
        children: [
          Positioned(
            top: -200,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,                
              ),
              child: SvgPicture.asset(
                'assets/blobs/blob1.svg',
                width: 320,
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -30,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,                
              ),
              child: SvgPicture.asset(
                'assets/blobs/blob2.svg',
                width: 350,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 18,
                  right: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textWhite,
                        ),
                        children: [
                          TextSpan(
                              text: 'Welcome, ',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(
                            text: 'Gavin',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        color: AppColors.iconWhite,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      child: Stack(
                        children: [
                          Container(
                            // Need to extract and turn into PostCard widget
                            height: 550,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.gradientMediumPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/Skinny Dipping.png',
                                fit: BoxFit.cover,
                                alignment: const Alignment(0.3, 0),
                              ),
                            ),
                          ),
                          Container(
                            height: 550,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.8),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 30,
                            left: 20,
                            right:
                                20, // keeps text from going all the way to the edge of the card
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yusuf Gandali",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textWhite,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'The way of the water is a ritual of the people in the heart of the Asian continent... ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: AppColors.textWhite,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'more',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textDarkGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              FloatingActionButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {},
                backgroundColor: AppColors.gradientMediumPurple,
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
