import 'package:chating_app/Screens/chatpage.dart';
import 'package:chating_app/Screens/login_page.dart';
import 'package:chating_app/Screens/register_page.dart';
import 'package:flutter/material.dart';

class ShoubraChat extends StatelessWidget {
  const ShoubraChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        Chatpage.id : (context) => Chatpage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
