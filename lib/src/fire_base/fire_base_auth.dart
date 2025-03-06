import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_database/firebase_database.dart";

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.ref().child("users");

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((userCredential) {
      User? user = userCredential.user;
      if (user != null) {
        // success
        _createUser(user.uid, name, phone, onSuccess, onRegisterError);
      }
    }).catchError((error) {
      // TODO
      _onSignUpErr(error.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((userCredential) {
      print("On sign in success");
      onSuccess();
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        _onSignInErr(error.code, onSignInError);
      } else {
        onSignInError("Lỗi không xác định khi đăng nhập.");
      }
    });
  }

  void _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = {"name": name, "phone": phone};

    _userRef.child(userId).set(user).then((_) {
      // success
      onSuccess();
    }).catchError((error) {
      // TODO
      onRegisterError("SignUp fail, please try again");
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    switch (code) {
      case "invalid-email":
      case "user-disabled":
        onRegisterError("Invalid Email");
      case "wrong-password":
        onRegisterError("The password is Incorrect");
      case "user-not-found":
        onRegisterError("User not found");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
    }
  }

  void _onSignInErr(String code, Function(String) onSignInError) {
    switch (code) {
      case "invalid-email":
        onSignInError("Email không hợp lệ. Vui lòng nhập đúng định dạng.");
        break;
      case "user-disabled":
        onSignInError("Tài khoản này đã bị vô hiệu hóa.");
        break;
      case "wrong-password":
        onSignInError("Mật khẩu không đúng. Vui lòng thử lại.");
        break;
      case "user-not-found":
        onSignInError("Tài khoản không tồn tại. Vui lòng kiểm tra lại email.");
        break;
      case "network-request-failed":
        onSignInError("Lỗi kết nối mạng. Vui lòng kiểm tra Internet.");
        break;
      default:
        onSignInError("Đăng nhập thất bại. Lỗi: $code");
    }
  }
}


// Bước 1: Gọi createUserWithEmailAndPassword() để đăng ký tài khoản.

// Bước 2: Nếu đăng ký thành công (then), lấy thông tin user.

// Bước 3: Nếu user != null, gọi hàm _createUser() để lưu thông tin vào Firebase Database.

// Bước 4: Nếu có lỗi (catchError), gọi onError(error.message) để báo lỗi.