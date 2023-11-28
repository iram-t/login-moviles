import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'cosasrarasdelavida.somee.com';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    final respons = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(authData));
    // creo que obtiene el response de la llamada del body
    final Map<String, dynamic> decodedRespons = json.decode(respons.body);

    if (decodedRespons.containsKey('token')) {
      // Se guarda el token en un lugar seguro
      await storage.write(key: 'token', value: decodedRespons['token']);
      return null;
    } else {
      return decodedRespons['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/Login');

    final respons = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));

    final Map<String, dynamic> decodedRespons = json.decode(respons.body);

    if (decodedRespons.containsKey('token')) {
      await storage.write(key: 'token', value: decodedRespons['token']);
      return null;
    } else {
      return decodedRespons['error']['message'];
    }
  }

  // se borra el token para hacer el deslogeo (?)
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    // si no hay nada se manda vacio
    return await storage.read(key: 'token') ?? '';
  }
}
