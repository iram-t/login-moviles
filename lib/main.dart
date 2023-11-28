import 'package:flutter/material.dart';
import 'package:login/Pages/check_auth.dart';
import 'package:login/Pages/login.dart';
import 'package:login/Pages/home_page.dart';
import 'package:login/Pages/signup.dart';
import 'package:login/services/auth.dart';
import 'package:login/services/notification_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'checking',
        routes: {
          'login': (_) => LoginScreen(),
          'register': (_) => SignUpScreen(),
          'home': (_) => HomePage(),
          'checking': (_) => CheckAuthScreen(),
        },
        scaffoldMessengerKey: NotificationServices.messengerKey,
      );
}
