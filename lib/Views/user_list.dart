import 'package:flutter/material.dart';
import 'package:flutter_crud/Providers/usersProvider.dart';
import 'package:flutter_crud/Routes/app_routes.dart';
import 'package:flutter_crud/UIComponents/User_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersProvider dataSource = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Usuários'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.Signup);
              })
        ],
      ),
      body: ListView.builder(
        itemCount: dataSource.count,
        itemBuilder: (ctx, i) => UserTile(dataSource.byIndex(i)),
      ),
    );
  }
}
