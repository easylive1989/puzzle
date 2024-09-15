import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/authentication/data/firebase_authentication_repository.dart';
import 'package:puzzle/authentication/domain/authentication_repository.dart';
import 'package:puzzle/authentication/presentation/login/view/user_login_page.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/puzzle_list_page.dart';

import '../../../../widget_test_utils.dart';

late MockNavigator _mockNavigator;

main() {
  setUp(() {
    _mockNavigator = MockNavigator();
    _givenNavigatorActionOk();
  });

  testWidgets("should route to puzzle list page when user login success",
      (tester) async {
    await _givenUseLoginPage(tester);

    await tester.tap(find.text(l10n.guest_sign_in));

    verify(() => _mockNavigator.pushReplacementNamed(PuzzleListPage.route))
        .called(1);
  });
}

Future<void> _givenUseLoginPage(WidgetTester tester) async {
  await tester.givenView(Provider<AuthenticationRepository>.value(
    value: FirebaseAuthenticationRepository(
      FakeFirebaseAuth(),
    ),
    child: MockNavigatorProvider(
      navigator: _mockNavigator,
      child: const UserLoginPage(),
    ),
  ));
}

void _givenNavigatorActionOk() {
  when(() => _mockNavigator.canPop()).thenReturn(true);
  when(() => _mockNavigator.pushReplacementNamed(any())).thenAnswer((_) async {
    return null;
  });
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  final StreamController<User> _streamController = StreamController.broadcast();

  @override
  Stream<User> authStateChanges() {
    return _streamController.stream;
  }

  @override
  Future<UserCredential> signInAnonymously() async {
    _streamController.add(MockUser());
    return MockUserCredential();
  }

  @override
  Future<void> signOut() async {}
}

class MockUserCredential extends Mock implements UserCredential {}
