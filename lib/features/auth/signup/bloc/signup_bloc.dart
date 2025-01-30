import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repository/user_repository.dart';
import 'dart:math';
import 'signup_event.dart';
import 'signup_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc({required this.userRepository}) : super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUp);
  }

  Future<void> _onSignUp(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      List<Map<String, dynamic>> users = await userRepository.loadUsers();

      final emailExists = users.any((user) => user["email"] == event.email);

      if (emailExists) {
        emit(SignUpFailure(error: "Email is already registered"));
      } else {
        // Create new user
        final newUser = {
          "id": users.isNotEmpty ? users.last["id"] + 1 : 1, // Generate ID
          "name": event.name,
          "email": event.email,
          "password": event.password,
          "gender": event.gender,
          "language": event.language
        };

        users.add(newUser);
        await userRepository.saveUsers(users);

        emit(SignUpSuccess());
      }
    } catch (e) {
      emit(SignUpFailure(error: "Something went wrong"));
    }
  }
}
