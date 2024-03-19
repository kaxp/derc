import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/buttons/default_elevated_button.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
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
    return Column(
      children: [
        _BuildDismissButton(onStackDismissed: widget.onStackDismissed),
        Expanded(
          child: Stack(
            children: List.generate(widget.totalStackCount, (index) {
              final heightFactor = 0.82 - (0.1 * index);
              final isVisible = index <= widget.currentStackIndex;

              return BuildStackViewItem(
                color: _getStackItemColor(index),
                isVisible: isVisible,
                heightFactor: heightFactor,
                onStackChange: () {
                  if (widget.currentStackIndex != index) {
                    widget.onStackChange(index);
                  }
                },
                stackNumber: index + 1,
                stackItem: widget.stackItems[index],
                isStackFocused: index == widget.currentStackIndex,
              );
            }),
          ),
        ),
      ],
    );
  }

  Color _getStackItemColor(int index) {
    return index == 0
        ? const Color(0xff40465a)
        : index == 1
            ? const Color(0xff3a4051)
            : index == 2
                ? const Color(0xff344048)
                : const Color(0xff2e3943);
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
    );
  }
}