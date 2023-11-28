import 'package:flutter/material.dart';
import 'package:login/services/auth.dart';
import 'package:provider/provider.dart';

class DrawerInicio extends StatefulWidget {
  const DrawerInicio({super.key});

  @override
  State<DrawerInicio> createState() => _DrawerInicio();
}

class _DrawerInicio extends State<DrawerInicio> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Inicio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar Sesion'),
              onTap: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              }),
        ],
      ),
    );
  }
}
