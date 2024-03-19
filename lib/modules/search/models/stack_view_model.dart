import 'package:flutter/widgets.dart';

class StackViewModel {
  StackViewModel({
    this.secondaryChild,
    required this.primaryChild,
    required this.buttonTitle,
    required this.onButtonTap,
  });

  final Widget? secondaryChild;
  final Widget primaryChild;
  final String buttonTitle;
  final VoidCallback onButtonTap;
}
