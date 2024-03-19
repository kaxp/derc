import 'package:flutter/widgets.dart';

class StackViewModel {
  StackViewModel({
    this.secondaryChild,
    required this.primaryChild,
    required this.buttonTitle,
    required this.onButtonTap,
  });

  /// [secondaryChild] is visible when stack is in background.
  final Widget? secondaryChild;

  /// [primaryChild] is visible when stack is in foreground.
  final Widget primaryChild;

  /// [buttonTitle] is text associated with each stack view.
  final String buttonTitle;

  /// [onButtonTap] handle the click event on the stack view button.
  final VoidCallback onButtonTap;
}
