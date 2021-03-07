import 'package:flutter/material.dart';
import 'package:flutter_crud/Models/users.dart';
import 'package:flutter_crud/Providers/usersProvider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};
  var _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context).settings.arguments;
    this._user = user;
    if (_validate(user)) {
      _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => {saveTapped(context)},
          )
        ],
      ),
      body: getPadding(this._user),
    );
  }

  Padding getPadding(User user) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            setupIcon(user),
            TextFormField(
              initialValue: _formData['name'],
              decoration: InputDecoration(labelText: 'Nome: '),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'O Nome é Inválido.';
                }
              },
              onSaved: (value) => _formData['name'] = value,
            ),
            TextFormField(
              initialValue: _formData['email'],
              decoration: InputDecoration(labelText: 'E-mail: '),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'E-mail Inválido.';
                }
              },
              onSaved: (value) => _formData['email'] = value,
            ),
            TextFormField(
              initialValue: _formData['avatarUrl'],
              decoration: InputDecoration(labelText: 'Link do Avatar: '),
              onSaved: (value) => _formData['avatarUrl'] = value,
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar setupIcon(User user) {
    return !(_validate(user)) || user.avatarUrl.isEmpty
        ? setDefaultIcon()
        : setUserIcon(user.avatarUrl);
  }

  CircleAvatar setDefaultIcon() {
    return CircleAvatar(child: Icon(Icons.person));
  }

  CircleAvatar setUserIcon(String avatarUrl) {
    return CircleAvatar(backgroundImage: NetworkImage(avatarUrl));
  }

  bool _validate(User user) {
    return user != null;
  }

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  void saveTapped(BuildContext context) {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      Provider.of<UsersProvider>(context, listen: false).add(
        User(
            id: _formData['id'],
            name: _formData['name'],
            email: _formData['email'],
            avatarUrl: _formData['avatarUrl']),
      );
      Navigator.of(context).pop();
    }
  }
}
