import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/providers/register_form_provider.dart';
import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.registerProvider,
  });
  final RegisterFormProvider registerProvider;

  @override
  Widget build(BuildContext context) {
    Color strengthColor;
    if (registerProvider.passwordStrength <= 0.33) {
      strengthColor = Colors.red;
    } else if (registerProvider.passwordStrength <= 0.66) {
      strengthColor = Colors.orange;
    } else {
      strengthColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: registerProvider.passwordStrength,
              minHeight: 8,
              backgroundColor: AppColors.whiteWithOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            registerProvider.passwordSuggestion,
            style: TextStyle(
              color: AppColors.whiteWithOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children:
                registerProvider.passwordRequirements.entries.map((entry) {
              final met = entry.value;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: met
                      ? AppColors.whiteWithOpacity(0.12)
                      : Colors.red.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      met ? Icons.check_circle : Icons.radio_button_unchecked,
                      size: 14,
                      color: met ? Colors.greenAccent : Colors.redAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      entry.key,
                      style: TextStyle(
                        color: AppColors.whiteWithOpacity(0.9),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
