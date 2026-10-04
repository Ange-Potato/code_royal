// Widget tests for Code Royal.
// Run them all with: flutter test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:code_royal/main.dart';
import 'package:code_royal/screens/main_menu_screen.dart';
import 'package:code_royal/screens/profile_screen.dart';
import 'package:code_royal/widgets/primary_button.dart';

void main() {
  setUp(() {
    // Fresh, empty storage before every test.
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('main menu shows title and the three buttons', (tester) async {
    await tester.pumpWidget(const CodeRoyalApp());

    // App starts in a loading state while progress is read from storage.
    await tester.pumpAndSettle();

    expect(find.text('CODE ROYAL'), findsOneWidget);
    expect(find.text('CODE BATTLE RPG'), findsOneWidget);
    expect(find.text('BATTLE'), findsOneWidget);
    expect(find.text('PROFILE'), findsOneWidget);
    expect(find.text('QUIT'), findsOneWidget);
  });

  testWidgets('new player starts at level 0 with 0 XP', (tester) async {
    await tester.pumpWidget(const CodeRoyalApp());
    await tester.pumpAndSettle();

    expect(find.text('LVL: 0'), findsOneWidget);
    expect(find.text('0/500'), findsOneWidget);
  });

  testWidgets('tapping Profile opens the Player Profile screen',
      (tester) async {
    await tester.pumpWidget(const CodeRoyalApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(PrimaryButton, 'PROFILE'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('PLAYER PROFILE'), findsOneWidget);
  });

  testWidgets('profile back button returns to the main menu', (tester) async {
    await tester.pumpWidget(const CodeRoyalApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(PrimaryButton, 'PROFILE'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileScreen), findsOneWidget);

    // The round back pill on the profile screen.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(MainMenuScreen), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);
  });
}