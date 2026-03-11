import 'package:aperture/utils/colors.dart';
import 'package:aperture/widgets/app_button.dart';
import 'package:aperture/widgets/blobs.dart';
import 'package:aperture/widgets/caption_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController _captionController = TextEditingController();
  FocusNode _captionFocusNode = FocusNode();

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
            blobPath: 'assets/blobs/blob3.svg',
            svgWidth: 490,
            topPosition: -100,
            leftPosition: -50,
          ),
          const Blobs(
            blobPath: 'assets/blobs/blob1.svg',
            svgWidth: 490,
            topPosition: 800,
            leftPosition: 50,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Make A Post',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                    alignment: Alignment.centerLeft,
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
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: AppColors.overlayDark,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CaptionTextField(captionController: _captionController, captionFocusNode: _captionFocusNode),
                  const SizedBox(
                    height: 30,
                  ),
                  AppButton(
                    btnText: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_rounded,
                          color: Colors.white,
                          size: 20,
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
                    btnColor: Colors.deepPurple,//AppColors.gradientPurple,
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