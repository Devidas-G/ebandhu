import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //Domain usecases
  final Login login;
  final Signup signup;
  final Logout logout;
  AuthBloc({required this.login, required this.signup, required this.logout})
    : super(AuthInitial()) {
    on<SignUpEvent>(
      _onSignUp,
      transformer: throttleDroppable(throttleDuration),
    );
    on<LoginEvent>(_onLogin, transformer: throttleDroppable(throttleDuration));
    on<LogoutEvent>(
      _onLogout,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signup(
      SignUpParams(
        email: event.email,
        password: event.password,
        userName: event.userName,
      ),
    );
    // result.fold(
    //   (failure) => emit(AuthError(failure.message)),
    //   (user) => emit(AuthAuthenticated(user)),
    // );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await login(
      LoginParams(email: event.email, password: event.password),
    );
    // result.fold(
    //   (failure) => emit(AuthError(failure.message)),
    //   (user) => emit(AuthAuthenticated(user)),
    // );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthLoggedOut()),
    );
  }
}
