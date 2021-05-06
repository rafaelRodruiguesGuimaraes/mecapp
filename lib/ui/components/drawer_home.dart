import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final Function onTap;

  const HomeDrawer({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Seu App',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            trailing: Icon(Icons.exit_to_app),
            title: Text('Sair do app'),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
