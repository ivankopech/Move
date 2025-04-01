import 'package:flutter/material.dart';
import 'package:move/utils/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 48,
        height: 48,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            appColors.primaryColor,
          ),
          strokeWidth: 4.0,
        ),
      ),
    );
  }
}
