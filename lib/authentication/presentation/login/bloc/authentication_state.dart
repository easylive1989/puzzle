part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {}

class Authenticated extends AuthenticationState {
  final PuzzleUser user;

  Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
