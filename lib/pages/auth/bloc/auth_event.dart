import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email, password;

  LoginRequested(this.email, this.password);
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested(this.email);
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;
  RegisterRequested(this.email, this.password, this.displayName);
}

class LogoutRequested extends AuthEvent {}
