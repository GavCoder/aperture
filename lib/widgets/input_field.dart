import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final IconData prefixIcon;
  final String? errorText;
  final bool obscureText;
  final int? maxLength;
  final Widget? suffixIcon;
  const InputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon, this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          maxLength: maxLength,
          style: const TextStyle(color: AppColors.textWhite),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.hintTextColor,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.hintTextColor,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: errorText != null
                ? Colors.red.withValues(alpha: 0.1)
                : AppColors.inputFillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red.withValues(alpha: 0.5)
                    : BorderSide.none.color,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}