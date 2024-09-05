import 'package:flutter/material.dart';
import 'package:flutter_application_1/accountpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
  if (_formKey.currentState!.validate()) {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('รหัสผ่านไม่ตรงกัน')),
      );
      return; // Exit the function if passwords do not match
    }

    final response = await http.post(
      Uri.parse('http://192.168.173.28/signup/changepassword.php'),
      body: {
        'id': '1',
        'new_password': _newPasswordController.text,
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating password')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เปลี่ยนรหัสผ่าน')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset("lib/assets/mushroom.png", width: 150, height: 90),
              const SizedBox(height: 20),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่านปัจจุบัน',
                  border: OutlineInputBorder(), // Add this line for border
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0), // Customize focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), // Customize enabled border
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่านใหม่',
                  border: OutlineInputBorder(), // Add this line for border
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0), // Customize focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), // Customize enabled border
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'ยืนยันรหัสผ่านใหม่',
                  border: OutlineInputBorder(), // Add this line for border
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0), // Customize focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), // Customize enabled border
                  ),
                ),
                validator: (val) {
                        if (val!.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        } else if (val != _confirmPasswordController.text) {
                          return 'รหัสไม่ตรงกัน';
                        }
                        return null;
                      },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 61, 167, 249),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  _updatePassword();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen(
                              username: '',
                              user_id: '',
                            )),
                  );
                },
                child: const Text(
                  'เปลี่ยนรหัสผ่าน',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
