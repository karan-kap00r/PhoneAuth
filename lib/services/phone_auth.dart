// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth {

  final String phoneNo;
  String? _verificationId;
  String? errorMessage;
  //for FireBase Auth
  final auth = FirebaseAuth.instance;

  PhoneAuth({required this.phoneNo});


  Future<void> verifyPhone(BuildContext context) async {

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) { },
      codeSent: (String verificationId, int? forceResendingToken) async {
       String smsCode = 'xxxxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        //
        // // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);

        // verifyCode(verificationId, smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
    );

  void signout() {
    auth.signOut();
  }
}

  Future<void> signInWithPhoneNumber(String verificationId, String smsCode, BuildContext context)
  async {
    try {
      // AuthCredential credential = PhoneAuthProvider.credential(
      //     verificationId: verificationId, smsCode: smsCode);
      PhoneAuthCredential credential =
      PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      await auth.signInWithCredential(credential);

      // UserCredential userCredential =
      //     await auth.signInWithCredential(credential);

      //     //todo verification complete
      //     //   print('signedIn 333');
      Navigator.of(context).pop();
      // }
    } catch (e) {
      print(e);
    }
  }
}
