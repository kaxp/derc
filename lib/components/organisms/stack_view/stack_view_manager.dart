import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/buttons/default_elevated_button.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/home/pages/search_page.dart';

class StackViewManager extends StatefulWidget {
  const StackViewManager({
    required this.totalStackCount,
    required this.currentStackIndex,
    required this.stackItems,
    required this.onStackDismissed,
    required this.onStackChange,
  }) : assert(
          totalStackCount >= 2 && totalStackCount <= 4,
          'Number of stacks must be between 2 and 4.',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: widget.onStackDismissed,
              icon: const Icon(
                Icons.clear,
                color: AppColors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: List.generate(widget.totalStackCount, (index) {
              final heightFactor = 0.82 - (0.1 * index);
              final isVisible = index <= widget.currentStackIndex;

              return StackViewItem(
                color: index == 0
                    ? const Color(0xff40465a)
                    : index == 1
                        ? const Color(0xff3a4051)
                        : index == 2
                            ? const Color(0xff344048)
                            : const Color(0xff2e3943),
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
}

class StackViewItem extends StatelessWidget {
  const StackViewItem({
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
            children: [
              Visibility(
                visible: !isStackFocused,
                child: stackItem?.secondaryChild ?? const SizedBox.shrink(),
              ),
              Expanded(
                child: Center(
                    child: stackItem?.primaryChild ?? const SizedBox.shrink()),
              ),
              const SizedBox(height: 20),
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
