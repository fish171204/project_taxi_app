import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';
import 'package:taxi_app/src/resources/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = AuthBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
        // elevation : set = 0 -> bỏ shadow viền của appbar
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        // Trường hợp các device nhỏ nên dùng SingleChildScrollView
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 30, 90, 0),
                child: Image.asset('assets/ic_car_red.png'),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(53, 30, 52, 0),
                child: Text(
                  "Welcome Aboard!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xff333333)),
                ),
              ),
              const Text(
                "Signup with Icab in simple steps",
                style: TextStyle(fontSize: 16, color: Color(0xff686470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: StreamBuilder(
                  // Lắng nghe stream bên Bloc
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) => TextField(
                    // controller để biết rằng người dùng nhập gì , từ đó lấy thông tin nhập kiểm tra nút "Sign up"
                    controller: _nameController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText:
                            snapshot.hasError ? snapshot.error as String : null,
                        labelText: "Name",
                        prefixIcon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/ic_user.png'),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  // Lắng nghe stream bên Bloc
                  stream: authBloc.phoneStream,
                  builder: (context, snapshot) => TextField(
                    controller: _phoneController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText:
                            snapshot.hasError ? snapshot.error as String : null,
                        labelText: "Phone Number",
                        prefixIcon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/ic_phone.png'),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  // Lắng nghe stream bên Bloc
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
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
                // Lắng nghe stream bên Bloc
                stream: authBloc.passStream,
                builder: (context, snapshot) => TextField(
                  controller: _passController,
                  obscureText: true,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error as String : null,
                      labelText: "Password",
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/ic_lock.png'),
                      ),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _onSignUpClicked,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: RichText(
                  text: const TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                      children: [
                        TextSpan(
                            text: "Login now",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff3277D8)))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpClicked() {
    var isValid = authBloc.isValid(
      _nameController.text,
      _emailController.text,
      _passController.text,
      _phoneController.text,
    );

    if (isValid) {
      // Đăng ký tài khoản
      authBloc.signUp(
        _emailController.text,
        _passController.text,
        _phoneController.text,
        _nameController.text,
        () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        (error) {
          print("Đăng ký thất bại: $error");
        },
      );
    }
  }
}
