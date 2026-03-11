import 'package:aperture/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaptionTextField extends StatelessWidget {
  const CaptionTextField({
    super.key,
    required TextEditingController captionController,
    required FocusNode captionFocusNode,
  }) : _captionController = captionController, _captionFocusNode = captionFocusNode;

  final TextEditingController _captionController;
  final FocusNode _captionFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 500,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      controller: _captionController,
      focusNode: _captionFocusNode,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      maxLines: null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white54.withOpacity(0.1),
        counterStyle: TextStyle(
          color: Colors.white54,
        ),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: _captionFocusNode.hasFocus
            ? IconButton(
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                ),
                onPressed: () => FocusScope.of(context).unfocus(),
              )
            : null,
        hintText: 'Add a caption...',
        labelText: _captionFocusNode.hasFocus ? 'Caption' : null,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        hintStyle: TextStyle(
          color: Colors.white54,
        ),
        suffixIcon: _captionController.text.isNotEmpty && _captionFocusNode.hasFocus
            ? IconButton(
                icon: Icon(
                  Icons.clear_rounded,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  _captionController.clear();
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.gradientPurple,
            width: 2,
          ),
        ),
      ),
    );
  }
}
