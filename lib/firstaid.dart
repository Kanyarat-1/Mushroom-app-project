import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navbar.dart';
import 'package:ionicons/ionicons.dart';

class FirstaidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "การปฐมพยาบาล",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Navbar(username: '', user_id: '',),
              ),
            );
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("lib/assets/firstaid1.jpg", width: 400, height: 200),
            const SizedBox(height: 20),
            Image.asset("lib/assets/firstaid2.jpg", width: 800, height: 200),
            const SizedBox(height: 20),
            Image.asset("lib/assets/firstaid3.jpg", width: 800, height: 200),
            const SizedBox(height: 20),
            Image.asset("lib/assets/firstaid4.jpg", width: 400, height: 200),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
