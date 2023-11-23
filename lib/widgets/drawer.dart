import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerInicio extends StatefulWidget {
  const DrawerInicio({super.key});

  @override
  State<DrawerInicio> createState() => _DrawerInicio();
}

class _DrawerInicio extends State<DrawerInicio> {
  @override
  Widget build(BuildContext context) {
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
            onTap: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}
