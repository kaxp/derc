import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget? child;
  final bool? isLoading;

  const LoadingOverlay({
    Key? key,
    this.isLoading,
    required this.child,
  })  : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isLoading!) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryColor),
        ),
      );
    }
    return child!;
  }
}
