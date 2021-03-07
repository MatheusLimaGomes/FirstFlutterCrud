import 'package:flutter/material.dart';
import 'package:flutter_crud/Providers/usersProvider.dart';
import 'package:flutter_crud/Routes/app_routes.dart';
import 'package:flutter_crud/Views/signup.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UsersProvider(),
      child: MaterialApp(
        title: 'MyFlutterApp',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserList(),
          AppRoutes.Signup: (_) => SignUp()
        },
      ),
    );
  }
}
