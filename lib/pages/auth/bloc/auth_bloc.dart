import 'package:admin_hrm/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../local/storage.dart';
import '../../../service/auth_service.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final UserRepository userRepository;

  AuthBloc(this.authService, this.userRepository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final credential =
            await authService.signIn(event.email, event.password);
        final user = credential.user;
        if (user == null) {
          emit(AuthFailure("Không tìm thấy người dùng."));
          return;
        }

        final appUser = await userRepository.fetchUserProfile();
        if (appUser.role != 'admin') {
          emit(AuthFailure("Bạn không có quyền truy cập admin."));
          return;
        }

        await StorageLocal.saveUser(appUser);
        emit(AuthSuccess(appUser));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final credential = await authService.signUp(
          email: event.email,
          password: event.password,
          displayName: event.displayName,
        );
        final appUser = await userRepository.fetchUserProfile();
        await StorageLocal.saveUser(appUser);
        emit(AuthSuccess(appUser));
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
