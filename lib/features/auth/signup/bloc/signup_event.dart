import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String language;

  SignUpButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.language,
  });

  @override
  List<Object?> get props => [name, email, password, gender, language];
}
