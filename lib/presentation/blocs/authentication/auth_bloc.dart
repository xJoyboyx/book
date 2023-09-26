import 'package:book/domain/usecases/session/signin/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;

  AuthBloc({required this.signInUseCase}) : super(AuthInitial()) {
    on<AutoLogin>(_onAutoLogin);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithApple>(_onSignInWithApple);
  }

  Future<void> _onAutoLogin(AutoLogin event, Emitter<AuthState> emit) async {
    final success = await signInUseCase.autoLogin();
    emit(success ? Authenticated() : Unauthenticated());
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<AuthState> emit) async {
    final credentials = await signInUseCase.signInWithGoogle();

    if (credentials.external_user_id.isNotEmpty) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInWithApple(
      SignInWithApple event, Emitter<AuthState> emit) async {
    final credentials = await signInUseCase.signInWithApple();
    if (credentials.external_user_id.isNotEmpty) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
