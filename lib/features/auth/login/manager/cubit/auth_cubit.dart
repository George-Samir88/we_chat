import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/cache_token.dart';
import 'package:we_chat/features/auth/login/manager/auth_repo/auth_repo.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> signInWithGoogle() async {
    emit(AuthLoadingState());
    var result = await authRepo.signInWithGoogle();
    result.fold((failure) {
      emit(AuthErrorState(error: failure.toString()));
    }, (userCredential) {
      //save token into shared Preferences
      saveTokenIntoSharedPreferences(token: userCredential.user!.uid);
      emit(AuthSuccessState(userCredential: userCredential));
    });
  }
}
