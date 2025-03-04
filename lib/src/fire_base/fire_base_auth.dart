import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_database/firebase_database.dart";

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.ref().child("users");

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((userCredential) {
      User? user = userCredential.user;
      if (user != null) {
        // success
        _createUser(user.uid, name, phone, onSuccess, onError);
      }
    }).catchError((error) {
      // TODO
      onError(error.message ?? "Đăng ký thất bại");
    });
  }

  void _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onError) {
    var user = {"name": name, "phone": phone};

    _userRef.child(userId).set(user).then((_) {
      // success
      onSuccess();
    }).catchError((error) {
      // TODO
      onError(error.message ?? "Lưu dữ liệu thất bại");
    });
  }
}


// Bước 1: Gọi createUserWithEmailAndPassword() để đăng ký tài khoản.

// Bước 2: Nếu đăng ký thành công (then), lấy thông tin user.

// Bước 3: Nếu user != null, gọi hàm _createUser() để lưu thông tin vào Firebase Database.

// Bước 4: Nếu có lỗi (catchError), gọi onError(error.message) để báo lỗi.