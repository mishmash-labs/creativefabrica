import 'package:bloc/bloc.dart';
import 'package:creative_fabrica/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Unauthenticated());

  final AuthRepository _authRepository = AuthRepository();

  void loginAnonymously() async {
    emit(Loading());
    try {
      await _authRepository.loginAnonymously();

      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  void checkStatus() async {
    emit(Loading());
    await Future.delayed(const Duration(milliseconds: 200));
    if (FirebaseAuth.instance.currentUser != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
