
import 'package:flutter/material.dart';
import 'shoubra_chat.dart';

import 'package:firebase_core/firebase_core.dart';

main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShoubraChat());
}
