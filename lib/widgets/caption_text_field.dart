import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

class CaptionTextField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLines;
  final String hintText;
  final String labelText;
  final int maxWords;

  const CaptionTextField({
    super.key,
    required this.controller,
    this.maxLines = 4,
    this.hintText = 'Add a caption...',
    this.labelText = 'Caption',
    this.maxWords = 500,
  });

  @override
  State<CaptionTextField> createState() => _CaptionTextFieldState();
}

class _CaptionTextFieldState extends State<CaptionTextField> {
  late int _wordCount;

  @override
  void initState() {
    super.initState();
    _wordCount = _calculateWordCount(widget.controller.text);
    widget.controller.addListener(() {
      setState(() {
        _wordCount = _calculateWordCount(widget.controller.text);
      });
    });
  }

  int _calculateWordCount(String text) {
    if (text.isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;// Split by whitespace and count words
  }

  InputDecoration _getDecoration(bool isEmpty) {
    return InputDecoration(
      hintText: isEmpty ? widget.hintText : null,
      labelText: isEmpty ? null : widget.labelText,
      suffixIcon: isEmpty
          ? null
          : IconButton(
              icon: const Icon(
                Icons.close,
                color: Color.fromARGB(255, 27, 11, 11),
              ),
              onPressed: () {
                widget.controller.clear();
              },
            ),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      hintStyle: const TextStyle(
        color: Colors.white54,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: AppColors.gradientOrange,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          decoration: _getDecoration(widget.controller.text.isEmpty),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '$_wordCount / ${widget.maxWords} words',
            style: TextStyle(
              color: _wordCount > widget.maxWords
                  ? Colors.red
                  : Colors.white54,
            ),
          ),
        ),
      ],
    );
  }
}
