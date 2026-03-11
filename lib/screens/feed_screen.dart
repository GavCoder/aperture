
import 'package:aperture/utils/colors.dart';
import 'package:aperture/widgets/blobs.dart';
import 'package:aperture/widgets/popup_menu_widget.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed SafeArea to allow background blobs to extend to edges of screen
      body: Stack(
        children: [
          const Blobs(
            blobPath: 'assets/blobs/blob1.svg',
            svgWidth: 320,
            topPosition: -200,
            leftPosition: -50,
          ),
          const Blobs(
            blobPath: 'assets/blobs/blob2.svg',
            svgWidth: 350,
            bottomPosition: -150,
            rightPosition: -30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
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
                    PopUpMenu(),
                    // GestureDetector(
                    //   onTap:
                    //       () {}, // TODO: Implement profile page and navigation
                    //   child: Image.asset(
                    //     'assets/images/Logo.png',
                    //     height: 30,
                    //     width: 30,
                    //     errorBuilder: (context, error, stackTrace) {
                    //       return const Icon(
                    //         Icons.camera_alt,
                    //         color: AppColors.textWhite,
                    //         size: 40,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
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
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 20,
                            right:
                                20, // keeps text from going all the way to the edge of the card
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Yusuf Gandali",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text.rich(
                                  TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textWhite,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            'The way of the water is a ritual of the people in the heart of the Asian continent... ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: AppColors.textWhite,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap:
                                              () {}, // TODO: Implement "more" functionality to expand text
                                          child: const Text(
                                            'more',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textLightGrey,
                                            ),
                                          ),
                                        ),
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
