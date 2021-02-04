import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseAuth _auth = FirebaseAuth.instance;

  Future<int> authenticateUser(String phoneNo, String code) async {
    return null;
  }

  // Future<FirebaseUser> getCurrentUser() => _auth.currentUser();

  // Future<AuthResult> signInWithCredential(AuthCredential credential) async =>
  //     await _auth.signInWithCredential(credential);

  // Future<void> verifyPhoneNumber(
  //     String phone,
  //     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  //     PhoneCodeSent codeSent,
  //     Duration duration,
  //     PhoneVerificationCompleted verificationCompleted,
  //     PhoneVerificationFailed verificationFailed) async {
  //   return _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //       codeSent: codeSent,
  //       timeout: duration,
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed);
  // }

  Future<void> registerUser(
      String firstName,
      String city,
      String username,
      String phoneNumber,
      String password,
      String bankName,
      String accountNumber) async {
    return _firestore.collection("users").doc(phoneNumber).set({
      'firstName': firstName,
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
      'bankName': bankName,
      'accountNumber': accountNumber,
    });
  }
}
