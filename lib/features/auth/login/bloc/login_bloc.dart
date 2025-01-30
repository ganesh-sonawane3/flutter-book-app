import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repository/user_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLogin);
  }

  Future<void> _onLogin(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      List<Map<String, dynamic>> users = await userRepository.loadUsers();

      final user = users.firstWhere(
        (user) => user["email"] == event.email && user["password"] == event.password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginFailure(error: "Invalid credentials"));
      }
    } catch (e) {
      emit(LoginFailure(error: "Something went wrong"));
    }
  }
}
