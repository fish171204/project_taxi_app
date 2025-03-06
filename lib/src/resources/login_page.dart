import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:taxi_app/src/app.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';
import 'package:taxi_app/src/resources/dialog/loading_dialog.dart';
import 'package:taxi_app/src/resources/dialog/msg_dialog.dart';
import 'package:taxi_app/src/resources/home_page.dart';
import 'package:taxi_app/src/resources/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc authBloc = AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        // Trường hợp các device nhỏ nên dùng SingleChildScrollView
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 170, 90, 0),
                child: Image.asset('assets/ic_car_green.png'),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(95, 30, 95, 0),
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xff333333)),
                ),
              ),
              const Text(
                "Login to continue using iCab",
                style: TextStyle(fontSize: 16, color: Color(0xff686470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 125, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    controller: _emailController,
                    decoration: InputDecoration(
                        errorText:
                            snapshot.hasError ? snapshot.error as String : null,
                        labelText: "Email",
                        prefixIcon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/ic_mail.png'),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                  ),
                ),
              ),
              StreamBuilder(
                stream: authBloc.passStream,
                builder: (context, snapshot) => TextField(
                  controller: _passController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error as String : null,
                      labelText: "Password",
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/ic_phone.png'),
                      ),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _onLoginClick,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Log in",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: RichText(
                  text: TextSpan(
                    text: "New user? ",
                    style:
                        const TextStyle(color: Color(0xff606470), fontSize: 16),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                        text: "Sign up for a new account",
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xff3277D8)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    var isValidSignIn = authBloc.isValidSignIn(
      _emailController.text,
      _passController.text,
    );

    if (isValidSignIn) {
      String email = _emailController.text;
      String pass = _passController.text;
      LoadingDialog.showLoadingDialog(context, "Đang nhập , vui lòng đợi!");
      authBloc.signIn(email, pass,
          // Đăng nhập thành công
          () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
          // Đăng nhập thất bại
          (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign-In", msg);
      });
    }
  }
}
