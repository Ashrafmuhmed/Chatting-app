import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../CustomWidgets/CustomedButton.dart';
import '../CustomWidgets/CustomedTextField.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static const String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 54,
      inAsyncCall: isLoading,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.lightBlue,
                  Color.fromARGB(255, 255, 102, 0)
                ])),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'SignUp',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cantarell'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFieldCustomed(
                        onChange: (data) {
                          email = data;
                        },
                        hint: 'Email',
                        secured: false),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldCustomed(
                        onChange: (data) {
                          password = data;
                        },
                        secured: true,
                        hint: 'Password'),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomedButton(
                      onTap: () async {
                        var auth = FirebaseAuth.instance;
                        if (formkey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await regestirationService(auth);
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ShowSnackbar(
                                  context: context,
                                  message:
                                      'Your password is weak , try another one.');
                            } else if (e.code == 'email-already-in-use')
                              ShowSnackbar(
                                  context: context,
                                  message: 'Email already has an account.');
                          } catch (e) {
                            ShowSnackbar(
                                context: context, message: 'Try again !!');
                          }
                        } else {
                          ShowSnackbar(
                              context: context, message: 'Try again :)');
                        }
                        isLoading = false;
                        setState(() {});
                      },
                      title: 'SignUp',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'Already have an account ? ',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Text(
                            'LogIn',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ShowSnackbar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(Icons.error),
        SizedBox(
          width: 20,
        ),
        Text(message),
      ],
    )));
  }

  Future<void> regestirationService(FirebaseAuth auth) async {
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
