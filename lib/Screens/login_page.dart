import 'package:chating_app/Screens/chatpage.dart';
import 'package:chating_app/Screens/register_page.dart';
import 'package:chating_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../CustomWidgets/CustomedButton.dart';
import '../CustomWidgets/CustomedTextField.dart';
import '../Helper/SnackBarWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static final String id = 'loginpage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  late String password, username;
  String? email;
  Usermodel? user;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                  Color.fromARGB(255, 1, 255, 52)
                ])),
            child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Image(
                      image: AssetImage('assets/pictures/speak.png'),
                      width: 200,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chat IT',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cantarell'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    const Row(
                      children: [
                        Text(
                          'LogIn',
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
                        hint: 'Email',
                        onChange: (value) {
                          email = value;
                        },
                        secured: false),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldCustomed(
                        hint: 'Password',
                        onChange: (value) {
                          password = value;
                        },
                        secured: true),
                    SizedBox(
                      height: 15,
                    ),
                    CustomedButton(
                      title: 'Login',
                      onTap: () async {
                        var auth = FirebaseAuth.instance;
                        if (formkey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await LoginUser(auth);
                            Snackbarwidget().ShowSnackbar(
                                context: context, message: 'Success');
                            user = Usermodel(email: email!);
                            Navigator.pushNamed(context, Chatpage.id,
                                arguments: user);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'too-many-requests') {
                              Snackbarwidget().ShowSnackbar(
                                  context: context,
                                  message:
                                      'wait bro you fucked the database !!');
                            } else {
                              Snackbarwidget().ShowSnackbar(
                                  context: context,
                                  message: 'Invalid email or password');
                            }
                            
                          } catch (e) {
                            Snackbarwidget().ShowSnackbar(
                                context: context, message: 'Try again !!');
                          }
                        } else {
                          Snackbarwidget().ShowSnackbar(
                              context: context, message: 'Try again :)');
                        }
                        isLoading = false;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have an account, ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, RegisterPage.id),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Forgot your password ? ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () => {
                            if (email == null)
                              {
                                Snackbarwidget().ShowSnackbar(
                                    context: context,
                                    message:
                                        'Write your email in the field first')
                              }
                            else
                              {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email!),
                                Snackbarwidget().ShowSnackbar(
                                    context: context,
                                    message: 'See your mail now !!')
                              }
                          },
                          child: const Text(
                            'reset your password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
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

  Future<void> LoginUser(FirebaseAuth auth) async {
    await auth.signInWithEmailAndPassword(email: email!, password: password);
  }
}
