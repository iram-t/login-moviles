import 'package:flutter/material.dart';
import 'package:login/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      drawer: const DrawerInicio(),
      body: const Center(
        child: Text('AHHHHHHHHHHHHHHHHHH'),
      ),
    );
  }
}
