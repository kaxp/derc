import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/buttons/default_elevated_button.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/radius_constants.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';

class StackViewManager extends StatefulWidget {
  const StackViewManager({
    required this.totalStackCount,
    required this.currentStackIndex,
    required this.stackItems,
    required this.onStackDismissed,
    required this.onStackChange,
  })  : assert(
          totalStackCount >= 2 && totalStackCount <= 4,
          'Number of stacks must be between 2 and 4.',
        ),
        assert(
          totalStackCount >= 2,
          'Number of stacks must be at least 2',
        );

  final int totalStackCount;
  final int currentStackIndex;
  final Map<int, StackViewModel> stackItems;
  final VoidCallback onStackDismissed;
  final Function(int) onStackChange;

  @override
  _StackViewManagerState createState() => _StackViewManagerState();
}

class _StackViewManagerState extends State<StackViewManager> {
  @override
  Widget build(BuildContext context) {
    final totalStackCount = widget.totalStackCount;
    final onStackDismissed = widget.onStackDismissed;
    final currentStackIndex = widget.currentStackIndex;
    final stackItems = widget.stackItems;

    return Column(
      children: [
        _BuildDismissButton(onStackDismissed: onStackDismissed),
        Expanded(
          child: Stack(
            children: List.generate(totalStackCount, (index) {
              final heightFactor = 0.82 - (0.1 * index);
              final isVisible = index <= currentStackIndex;

              return BuildStackViewItem(
                color: _getStackItemColor(index),
                isVisible: isVisible,
                heightFactor: heightFactor,
                onStackChange: () {
                  if (currentStackIndex != index) {
                    widget.onStackChange(index);
                  }
                },
                stackNumber: index + 1,
                stackItem: stackItems[index],
                isStackFocused: index == currentStackIndex,
              );
            }),
          ),
        ),
      ],
    );
  }

  Color _getStackItemColor(int index) {
    return index == 0
        ? AppColors.stackViewColour1
        : index == 1
            ? AppColors.stackViewColour2
            : index == 2
                ? AppColors.stackViewColour3
                : AppColors.stackViewColour4;
  }
}

class _BuildDismissButton extends StatelessWidget {
  const _BuildDismissButton({required this.onStackDismissed});

  final VoidCallback onStackDismissed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          padding: const EdgeInsets.all(kSpacingMedium),
          onPressed: onStackDismissed,
          icon: const Icon(
            Icons.clear,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class BuildStackViewItem extends StatelessWidget {
  const BuildStackViewItem({
    required this.color,
    required this.isVisible,
    required this.heightFactor,
    required this.onStackChange,
    required this.stackNumber,
    required this.stackItem,
    required this.isStackFocused,
  });

  final Color color;
  final bool isVisible;
  final double heightFactor;
  final VoidCallback onStackChange;
  final int stackNumber;
  final StackViewModel? stackItem;
  final bool isStackFocused;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      left: 0,
      right: 0,
      bottom: isVisible ? 0 : -MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: const SmoothBorderRadius.only(
          topLeft: SmoothRadius(
            cornerRadius: kRadiusMedium,
            cornerSmoothing: 1,
          ),
          topRight: SmoothRadius(
            cornerRadius: kRadiusMedium,
            cornerSmoothing: 1,
          ),
        ),
        child: GestureDetector(
          onTap: onStackChange,
          child: Container(
            height: MediaQuery.of(context).size.height * heightFactor,
            padding: const EdgeInsets.all(kSpacingMedium),
            color: color,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  opacity: !isStackFocused ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Visibility(
                    visible: !isStackFocused,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: stackItem?.secondaryChild ??
                              const SizedBox.shrink(),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: isStackFocused,
                    child: Center(
                      child: stackItem?.primaryChild ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
                const SizedBox(height: kSpacingMedium),
                Container(
                  child: DefaultElevatedButton(
                    title: stackItem?.buttonTitle ?? '',
                    onPressed: () => stackItem?.onButtonTap(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
