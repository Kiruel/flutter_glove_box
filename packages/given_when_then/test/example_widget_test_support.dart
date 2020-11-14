import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then/given_when_then.dart';

Future<void> Function(WidgetTester) harness(WidgetTestHarnessCallback<_Harness> callback) {
  return (tester) => givenWhenThenWidgetTest(_Harness(tester), callback);
}

class _Harness extends WidgetTestHarness {
  _Harness(WidgetTester tester) : super(tester);
}

extension ExampleGiven on WidgetTestGiven<_Harness> {
  Future<void> preCondition() async {
    await tester.pumpWidget(WidgetUnderTest());
  }
}

extension ExampleWhen on WidgetTestWhen<_Harness> {
  Future<void> userPerformsSomeAction() async {
    await tester.tap(find.text('0'));
    await tester.pump();
  }
}

extension ExampleThen on WidgetTestThen<_Harness> {
  void makeSomeAssertion() {
    expect(find.text('1'), findsOneWidget);
  }
}

class WidgetUnderTest extends StatefulWidget {
  @override
  _WidgetUnderTestState createState() => _WidgetUnderTestState();
}

class _WidgetUnderTestState extends State<WidgetUnderTest> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _counter++;
          });
        },
        child: Text(_counter.toString()),
      ),
    );
  }
}
