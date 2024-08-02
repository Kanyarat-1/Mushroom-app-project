import 'package:flutter/material.dart';

class FirstaidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid'),
      ),
      body: Center(
        child: Text('Welcome to the first aid Page!'),
      ),
    );
  }
}