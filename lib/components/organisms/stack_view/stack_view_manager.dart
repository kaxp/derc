import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';

class StackViewManager extends StatefulWidget {
  const StackViewManager({
    required this.numberOfStacks,
    required this.onStackDismissed,
  });

  final int numberOfStacks;
  final VoidCallback onStackDismissed;
  @override
  _StackViewManagerState createState() => _StackViewManagerState();
}

class _StackViewManagerState extends State<StackViewManager> {
  int visibleStackIndex = 0;

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
            const Text(
              "Title",
              style: TextStyle(color: AppColors.white),
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
            children: List.generate(widget.numberOfStacks, (index) {
              final heightFactor =
                  0.75 - (0.1 * index); // Adjusted height factors
              final isVisible = index <= visibleStackIndex;
              return StackViewItem(
                title: 'Stack ${index + 1}',
                color: index == 0
                    ? Colors.blue
                    : index == 1
                        ? Colors.green
                        : index == 2
                            ? Colors.red
                            : Colors.orange,
                isVisible: isVisible,
                heightFactor: heightFactor,
                onPressed: () {
                  setState(() {
                    visibleStackIndex = index;
                  });
                },
                onNextPressed: () {
                  if (index < widget.numberOfStacks - 1) {
                    setState(() {
                      visibleStackIndex = index + 1;
                    });
                  }
                },
                stackNumber: index + 1,
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
    required this.title,
    required this.color,
    required this.isVisible,
    required this.heightFactor,
    required this.onPressed,
    required this.onNextPressed,
    required this.stackNumber,
  });

  final String title;
  final Color color;
  final bool isVisible;
  final double heightFactor;
  final VoidCallback onPressed;
  final VoidCallback onNextPressed;
  final int stackNumber;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      left: 0,
      right: 0,
      bottom: isVisible ? 0 : -MediaQuery.of(context).size.height,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: MediaQuery.of(context).size.height * heightFactor,
          color: color,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Stack: $stackNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onNextPressed,
                child: const Text('Open Next Stack'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
