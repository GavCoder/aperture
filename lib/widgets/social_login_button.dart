import 'package:aperture/utils/colors.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final String assetPath;
  final VoidCallback onPressed;
  
  const SocialLoginButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textWhite,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            height: 25,
            width: 25,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                label.contains('Google')
                    ? Icons.g_mobiledata
                    : Icons.facebook,
                color: AppColors.textDarkGrey,
                size: 20,
              );
            },
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDarkGrey,
            ),
          ),
        ],
      ),
    );
  }
}