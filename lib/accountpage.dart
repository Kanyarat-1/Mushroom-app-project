import 'package:flutter/material.dart';
import 'package:flutter_application_1/editusername.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/Navbar.dart';
import 'package:flutter_application_1/ChangePassword.dart';
import 'package:flutter_application_1/widgets/setting_item.dart';

class AccountScreen extends StatefulWidget {
  final String username;
  final String user_id;

  const AccountScreen({Key? key, required this.username,required this.user_id}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "บัญชีผู้ใช้",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("lib/assets/user.png", width: 70, height: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.username), // แสดง username ที่ได้รับมา
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "การตั้งค่า",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "เปลี่ยนชื่อบัญชีผู้ใช้",
                icon: Ionicons.create,
                bgColor: Colors.green.shade100,
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditAccountScreen(username: widget.username, user_id: '',),
                    ),
                  );
                }, 
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "เปลี่ยนรหัสผ่าน",
                icon: Ionicons.key,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(),
                    ),
                  );
                },
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ), 
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "ออกจากระบบ",
                icon: Ionicons.log_out,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
