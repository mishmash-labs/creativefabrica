part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class Loading extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  AuthError(this.error);

  final String error;
}
