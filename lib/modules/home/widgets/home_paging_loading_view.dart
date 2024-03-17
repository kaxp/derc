import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/molecules/loading_overlay/loading_overlay.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';

class HomePagingLoadingView extends StatelessWidget {
  const HomePagingLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(kSpacingMedium),
        child: LoadingOverlay(
          child: SizedBox.shrink(),
          isLoading: true,
        ),
      ),
    );
  }
}
