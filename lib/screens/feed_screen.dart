import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 18, right: 18),
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
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
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
                            horizontal: 10, vertical: 20),
                        child: Container(
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
                            ),
                          ),
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
          ),
          
          Positioned(
            top: 50,
            right: 50,
            child: SvgPicture.asset(
              'assets/blobs/blob1.svg',
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
