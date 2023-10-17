part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AutoLogin extends AuthEvent {}

class SignInWithGoogle extends AuthEvent {}

class SignInWithApple extends AuthEvent {}

class SignOut extends AuthEvent {}

class DeleteAcount extends AuthEvent {}
