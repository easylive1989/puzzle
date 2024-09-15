import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/authentication/domain/authentication_repository.dart';
import 'package:puzzle/authentication/domain/entity/puzzle_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<PuzzleUser>? _authStreamSubscription;

  AuthenticationCubit(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(Unauthenticated()) {
    _authStreamSubscription = _authenticationRepository.onAuthChange().listen((user) {
      emit(user != PuzzleUser.empty() ? Authenticated(user) : Unauthenticated());
    });
  }


  @override
  Future<void> close() {
    _authStreamSubscription?.cancel();
    return super.close();
  }

  Future<void> login() async {
    await _authenticationRepository.login();
  }

  Future<void> logout() async {
    await _authenticationRepository.logout();
  }
}
