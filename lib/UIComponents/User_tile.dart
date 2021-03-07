import 'package:flutter/material.dart';
import 'package:flutter_crud/Models/users.dart';
import 'package:flutter_crud/Providers/usersProvider.dart';
import 'package:flutter_crud/Routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return setupItems(context);
  }

  ListTile setupItems(BuildContext context) {
    return ListTile(
      leading: setupIcon(),
      title: getUserName(),
      subtitle: getUserEmail(),
      trailing: Container(
        width: 100,
        child: getPropertyRows(context),
      ),
    );
  }

  Row getPropertyRows(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.edit),
            color: Colors.lightGreen,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.Signup, arguments: user);
            }),
        IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              _getConfirmation(context);
            })
      ],
    );
  }

  Text getUserName() {
    return user.name == null || user.name.isEmpty ? Text("") : Text(user.name);
  }

  Text getUserEmail() {
    return user.email == null || user.email.isEmpty
        ? Text("")
        : Text(user.email);
  }

  CircleAvatar setupIcon() {
    return user.avatarUrl == null || user.avatarUrl.isEmpty
        ? setDefaultIcon()
        : setUserIcon(user.avatarUrl);
  }

  CircleAvatar setDefaultIcon() {
    return CircleAvatar(child: Icon(Icons.person));
  }

  CircleAvatar setUserIcon(String avatarUrl) {
    return CircleAvatar(backgroundImage: NetworkImage(avatarUrl));
  }

  void _getConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Atenção!',
        ),
        content: Text(
            'Você deseja Excluir esse usuário? \n\n Essa Ação não poderá ser desfeita.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed) {
        Provider.of<UsersProvider>(context, listen: false).remove(user);
      }
    });
  }
}
