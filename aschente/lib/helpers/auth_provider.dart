// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// enum Auth {
//   SignIn,
//   SignUp,
// }

// class AuthProvider extends ChangeNotifier {
//   late bool _isLoading;
//   late FirebaseAuth firebaseAuth;

//   late UserCredential user;
//   //GoogleSignIn _googleSignIn;

//   bool get isLoading => _isLoading;
//   set isLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   // OR await (_googleSignIn.isSignedIn()
//   Future<bool> isAuth() async {
//     return firebaseAuth.currentUser != null;
//   }

//   AuthProvider() {
//     firebaseAuth = FirebaseAuth.instance;
//     print('HEY');
//     _isLoading = false;
//   }
//   Future<String> authenticate(Map<String, String> data,
//       {Auth state = Auth.SignIn}) async {
//     print('HELLLLLOOOOOO');
//     if (state == Auth.SignUp) {
//       print('HELLLLLOOOOOO');

//       if (data['password'] != data['repassword'])
//         return 'Password doesn\'t match';
//     }

//     if (!data.containsKey('email') || data['email']!.isEmpty)
//       return 'Please enter your email';
//     if (!data.containsKey('password') || data['password']!.isEmpty)
//       return 'Please enter your password';
//     if (!RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(data['email']!)) return 'Please enter a valid email address';

//     try {
//       if (state == Auth.SignIn)
//         user = await firebaseAuth.signInWithEmailAndPassword(
//             email: data['email']!, password: data['password']!);
//       else {
//         user = await firebaseAuth.createUserWithEmailAndPassword(
//             email: data['email']!, password: data['password']!);
//         user.user!.updateProfile(displayName: data['username']);

//         await FirebaseFirestore.instance
//             .collection("users")
//             .doc(user.user!.uid)
//             .set(
//           {'email': data['email'], 'name': data['username']},
//         );
//       }
//     } catch (e) {
//       print("$e sadasd");
//       return '$e';
//     }

//     /// [todo] save user credentials.
//     print('object');
//     return 'success';
//   }
// }
