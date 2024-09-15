import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:puzzle/authentication/domain/authentication_repository.dart';
import 'package:puzzle/authentication/domain/entity/puzzle_user.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final StreamController<PuzzleUser> _streamController =
      StreamController.broadcast();

  FirebaseAuthenticationRepository(this._firebaseAuth) {
    _firebaseAuth.authStateChanges().listen((user) {
      _streamController.add(user != null
          ? PuzzleUser(
              id: user.uid,
              name: user.displayName ?? "",
              photoUrl: user.photoURL ?? "",
            )
          : PuzzleUser.empty());
    });
  }

  @override
  Future<void> login() async {
    await _firebaseAuth.signOut();
    await _firebaseAuth.signInAnonymously();
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<PuzzleUser> onAuthChange() {
    return _streamController.stream;
  }
}
