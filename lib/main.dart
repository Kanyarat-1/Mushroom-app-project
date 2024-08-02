import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'register.dart';
import 'Navbar.dart'; // Import Navbar
import 'provider.dart'; // Import your provider file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MushroomImageProvider()), // Initialize your providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/home': (context) {
            final username = ModalRoute.of(context)?.settings.arguments as String? ?? '';
            return Navbar(username: username);
          },
          'login': (context) => const Login(),
          'register': (context) => const Register(),
        }
      ),
    );
  }
}
