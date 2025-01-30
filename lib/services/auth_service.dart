import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myapp/features/auth/model/user_model.dart';


class AuthService {
  List<UserModel> _users = [];

  Future<void> loadUsers() async {
    String data = await rootBundle.loadString('data/users.json');
    List<dynamic> jsonList = json.decode(data);
    _users = jsonList.map((json) => UserModel.fromJson(json)).toList();
  }

  UserModel? authenticate(String email, String password) {
    return _users.firstWhere(
      (user) => user.email == email && user.password == password,
     
    );
  }

  bool registerUser(String name, String email, String password) {
    bool userExists = _users.any((user) => user.email == email);
    if (!userExists) {
      _users.add(UserModel(id: _users.length + 1, name: name, email: email, password: password));
      return true;
    }
    return false;
  }
}
