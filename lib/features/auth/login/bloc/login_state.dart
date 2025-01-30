import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

// Initial state
class LoginInitial extends LoginState {}

// Loading state
class LoginLoading extends LoginState {}

// Success state with user data
class LoginSuccess extends LoginState {
  final Map<String, dynamic> user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

// Failure state with error message
class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
