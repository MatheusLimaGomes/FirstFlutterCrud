import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/Data/dummy_users.dart';
import 'package:flutter_crud/Models/users.dart';

class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};
  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void add(User user) {
    var _id = generateRamdomID();
    if (validateHas(user)) {
      updateUser(user);
    } else {
      putUser(_id, user);
    }
    notifyListeners();
  }

  void remove(User user) {
    if (validateHas(user)) {
      _items.remove(user.id);
      notifyListeners();
    }
  }

  void putUser(String _id, User user) {
    _items.putIfAbsent(_id, () => createUser(_id, user));
  }

  void updateUser(User user) {
    _items.update(user.id, (_) => createUser(user.id, user));
  }

  bool validateHas(User user) {
    return (user != null &&
        _items.containsKey(user.id) &&
        user.id.trim().isNotEmpty);
  }

  User createUser(String _id, User data) {
    return User(
        id: _id, name: data.name, email: data.email, avatarUrl: data.avatarUrl);
  }

  String generateRamdomID() {
    return Random().nextDouble().toString();
  }
}
