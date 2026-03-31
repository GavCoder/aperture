import 'package:aperture/utils/colors.dart';
import 'package:aperture/widgets/app_button2.dart';
import 'package:aperture/widgets/blobs.dart';
import 'package:aperture/widgets/caption_textfield.dart';
import 'package:aperture/widgets/header.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final FocusNode _captionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _captionController.addListener(() {
      setState(() {});
    });
    _captionFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _captionController.dispose();
    _captionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Clean up the code and make it more modular by creating separate widgets for the post image, caption input, and upload button. Also, add functionality to actually upload the post and handle errors appropriately.
    return Scaffold(
      body: Stack(
        children: [
          const Blobs(
            blobPath: 'assets/blobs/blob4.svg',
            svgWidth: 1300,
            topPosition: -420,
            leftPosition: -550,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Header(
                    title: 'Make A Post',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Post Added Successfully!')),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.9),
                              Colors.white10.withOpacity(0.8),
                              Colors.white24.withOpacity(0.6),
                              Colors.white38.withOpacity(0.5),
                              Colors.white54.withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: AppColors.overlayDark,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CaptionTextField(
                      captionController: _captionController,
                      captionFocusNode: _captionFocusNode),
                  const SizedBox(
                    height: 30,
                  ),
                  AppButton2(
                    btnTitle: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post Added Successfully!'),
                        ),
                      );
                      setState(() {
                        //_isEditing = !_isEditing;
                        _captionController.clear();
                      });
                    },
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
