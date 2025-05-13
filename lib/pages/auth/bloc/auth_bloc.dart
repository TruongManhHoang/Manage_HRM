import 'package:admin_hrm/local/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential =
            await authService.signIn(event.email, event.password);
        final user = userCredential.user;
        if (user == null) {
          emit(AuthFailure("Không tìm thấy người dùng."));
          return;
        }
        final tokenResult = await user.getIdTokenResult(true);
        final isAdmin = tokenResult.claims?['admin'] == true;
        await StorageLocal.saveUser(
          token: tokenResult.token ?? '',
          email: user.email ?? '',
          displayName: user.displayName ?? '',
        );
        if (isAdmin) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure("Bạn không có quyền truy cập admin."));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.sendPasswordResetEmail(event.email);
        emit(ForgotPasswordSent());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.signOut();
        await StorageLocal.clearUser();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
