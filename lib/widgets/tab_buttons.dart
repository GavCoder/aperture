import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:flutter/material.dart';

/// Builds the login/register tab buttons
class TabButtons extends StatelessWidget {
  const TabButtons({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    bool isLogin = label.toLowerCase() == 'login';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.tabBackgroundInactiveColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: isLogin
            ? [
                // Login Tab
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.tabBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                // Register Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.registerRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xFFB3B3B3),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : [
                // Login Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.loginRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFB3B3B3),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Register Tab
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.tabBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}
