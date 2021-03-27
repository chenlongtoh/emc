import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static Future login({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("UserCredential => $userCredential");
      return userCredential?.user;
    } on FirebaseAuthException catch (e) {
      print("E ${e.code}");
      if (e.code == 'user-not-found') {
        EasyLoading.showError("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError("Wrong password provided for that user.");
      }
    }
  }

  static Future register() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: "email@email.email",
        password: "password",
      )
          .then((userCredential) {
        final String uid = userCredential?.user?.uid;
        if (uid != null) {
          CollectionReference users = FirebaseFirestore.instance.collection('users');
          users.doc().set({
            'name': "Cutie Pie",
            'age': "100",
            'isStudent': true,
          });
        }
      });
    } on FirebaseException catch (e) {
      print("Firebase Exception => $e");
    }
  }

  static Future checkIsStudent(String uid) async {
    try {
      bool isStudent = false;
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(uid).get().then((DocumentSnapshot snapshot) {
        print("snapshot.data() :: ${snapshot.data()}");
        isStudent = snapshot.data()["isStudent"];
      });
      return isStudent;
      // print("No Return");
    } on FirebaseException catch (e) {
      print("Firebase Exception => $e");
    }
  }
  
  static Future logout() async{
    try{
      await FirebaseAuth.instance.signOut();
    } on FirebaseException catch(e){
      print("Firebase Exception => $e");
    }
  }
}
    // try {
    //   UserCredential userCredential =
    //       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "barry.allen@example.com", password: "SuperSecretPassword!");
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
