import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

class ProfileEditingFields extends StatefulWidget {
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
  State<ProfileEditingFields> createState() => _ProfileEditingFieldsState();
}

class _ProfileEditingFieldsState extends State<ProfileEditingFields> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 44),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(style: BorderStyle.none),
            ),
            child: _isEditing
                ? TextField(
                    controller: _controller,
                    autofocus: true,
                    maxLines: null, // allows multiline (e.g. bio)
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your ${widget.heading.toLowerCase()} here',
                      filled: true,
                      fillColor: AppColors.inputFillColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.inputBorderColor),
                      ),
                      // clear button
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () => _controller.clear(),
                      ),
                    ),
                  )
                : Text(
                    _controller.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
          ),

          // Edit / Done icon button
          Positioned(
            bottom: 4,
            right: 2,
            child: IconButton(
              icon: Icon(
                _isEditing ? Icons.check_circle_outline : Icons.edit_square,
                size: 20,
              ),
              color: _isEditing ? AppColors.gradientOrange : Colors.grey[400],
              splashColor: AppColors.gradientOrange,
              tooltip: _isEditing ? 'Save' : widget.toolTip,
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
            ),
          ),

          // Heading
          Positioned(
            top: 0,
            left: 10,
            child: Text(
              widget.heading,
              style: const TextStyle(
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