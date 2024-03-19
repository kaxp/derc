import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kapil_sahu_cred/components/organisms/stack_view_manager/stack_view_manager.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';

void main() {
  setUp(() {});

  testWidgets('''Given StackViewManager is opened
    When Dismiss button callback is triggered
    Then StackViewManager should close''', (tester) async {
    bool dismissed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StackViewManager(
          totalStackCount: 3,
          currentStackIndex: 0,
          stackItems: const {},
          onStackDismissed: () {
            dismissed = true;
          },
          onStackChange: (index) {},
        ),
      ),
    );

    await tester.tap(find.byType(IconButton));
    expect(dismissed, true);
  });

  testWidgets('''Given StackViewManager is opened
    When user tap on StackItem
    Then item tap callback should triggered''', (WidgetTester tester) async {
    int tappedIndex = 0;

    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 0));

    await tester.tap(find.byType(GestureDetector).first);
    expect(tappedIndex, 0);
  });

  testWidgets('''Given StackViewManager is opened
    When the expanded stack are tapped
    Then buttonTap callback is triggered for each stack item''',
      (WidgetTester tester) async {
    int tappedIndex = -1;

    await tester.pumpWidget(_buildStackViewManager(
        currentStackIndex: 2,
        buttonTap: () {
          tappedIndex += 1;
        }));

    await tester.tap(find.text('Button 1'));
    expect(tappedIndex, 0);

    await tester.tap(find.text('Button 2'));
    expect(tappedIndex, 1);

    await tester.tap(find.text('Button 3'));
    expect(tappedIndex, 2);
  });

  testWidgets('''Given StackViewManager is opened
    When totalStackCount is 1
    Then stack framework should throw assertion error as min count is 2''',
      (WidgetTester tester) async {
    expect(
      () => StackViewManager(
        totalStackCount: 1,
        currentStackIndex: 0,
        stackItems: const {},
        onStackDismissed: () {},
        onStackChange: (index) {},
      ),
      throwsAssertionError,
    );
  });

  testWidgets('''Given StackViewManager is opened
    When totalStackCount is 2
    Then two stack views should appear''', (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(totalStackCount: 2));

    expect(find.byType(BuildStackViewItem), findsNWidgets(2));
  });

  testWidgets('''Given StackViewManager is opened
    When totalStackCount is 3
    Then three stack views should appear''', (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(totalStackCount: 3));

    expect(find.byType(BuildStackViewItem), findsNWidgets(3));
  });

  testWidgets('''Given StackViewManager is opened
    When totalStackCount is 4
    Then four stack views should appear''', (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(totalStackCount: 4));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
  });

  testWidgets('''Given StackViewManager is opened
    When totalStackCount is 5
   Then stack framework should throw assertion error as min count is 4''',
      (WidgetTester tester) async {
    expect(
      () => StackViewManager(
        totalStackCount: 5,
        currentStackIndex: 0,
        stackItems: const {},
        onStackDismissed: () {},
        onStackChange: (index) {},
      ),
      throwsAssertionError,
    );
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 0
    Then 1rd stack items should be visible''', (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 0));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Primary Child 1'), findsOneWidget);
    expect(find.text('Primary Child 2'), findsNothing);
    expect(find.text('Primary Child 3'), findsNothing);
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 1
    Then 2rd stack item should be visible''', (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 1));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Primary Child 1'), findsNothing);
    expect(find.text('Primary Child 2'), findsOneWidget);
    expect(find.text('Primary Child 3'), findsNothing);
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 2
    Then 3rd stack item should be visible''', (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 2));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Primary Child 1'), findsNothing);
    expect(find.text('Primary Child 2'), findsNothing);
    expect(find.text('Primary Child 3'), findsOneWidget);
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 3
    Then non the the first 3 stack items should be visible''',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 3));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Primary Child 1'), findsNothing);
    expect(find.text('Primary Child 2'), findsNothing);
    expect(find.text('Primary Child 3'), findsNothing);
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 0, i.e Primary Child 1 is expanded
    Then Secondary Child of 1st stack item should not be visible''',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 0));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Secondary Child 1'), findsNothing);
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 1, i.e Primary Child 2 is expanded
    Then Secondary Child of 2nd stack item should not be visible''',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 1));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Secondary Child 2'), findsNothing);
  });

  testWidgets('''Given StackViewManager is opened
    When the currentStackIndex is 2, i.e Primary Child 3 is expanded
    Then Secondary Child of first stack item should not be visible''',
      (WidgetTester tester) async {
    await tester.pumpWidget(_buildStackViewManager(currentStackIndex: 2));

    expect(find.byType(BuildStackViewItem), findsNWidgets(4));
    expect(find.text('Secondary Child 3'), findsNothing);
  });
}

Widget _buildStackViewManager(
    {int? currentStackIndex, VoidCallback? buttonTap, int? totalStackCount}) {
  return MaterialApp(
    home: StackViewManager(
      totalStackCount: totalStackCount ?? 4,
      currentStackIndex: currentStackIndex ?? 0,
      stackItems: {
        0: _buildStackViewModel(
            'Primary Child 1', 'Secondary Child 1', 'Button 1',
            buttonTap: buttonTap),
        1: _buildStackViewModel(
            'Primary Child 2', 'Secondary Child 2', 'Button 2',
            buttonTap: buttonTap),
        2: _buildStackViewModel(
            'Primary Child 3', 'Secondary Child 3', 'Button 3',
            buttonTap: buttonTap),
        3: _buildStackViewModel(
            'Primary Child 4', 'Secondary Child 4', 'Button 4',
            buttonTap: buttonTap),
      },
      onStackDismissed: () {},
      onStackChange: (index) {},
    ),
  );
}

StackViewModel _buildStackViewModel(
    String primaryChildText, String secondaryChildText, String buttonTitle,
    {VoidCallback? buttonTap}) {
  return StackViewModel(
    primaryChild: Text(primaryChildText),
    secondaryChild: Text(secondaryChildText),
    buttonTitle: buttonTitle,
    onButtonTap: buttonTap ?? () {},
  );
}
