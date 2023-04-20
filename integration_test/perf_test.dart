// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_codelab/main.dart';

/// Run:
/// flutter test integration_test/perf_test.dart
///

void main() {
  group('TestingApp', () {
    //XXX: ensure driver is ready
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    //XXX: to test anims
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Performance', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final list = find.byType(ListView);

      //XXX: record actions and generate a summary
      await binding.traceAction(() async {
        await tester.fling(list, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(list, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: "scrolling_summary");
    });
  });
}
