import 'package:puzzle/authentication/domain/entity/puzzle_user.dart';

abstract class AuthenticationRepository {

  Future<void> login();

  Future<void> logout();

  Stream<PuzzleUser> onAuthChange();
}