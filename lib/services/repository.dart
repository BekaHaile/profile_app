import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/services/firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<void> registerUser(context, User user) async {
    print('sending');
    try {
      await _firestoreProvider.registerUser(user.firstName, user.city,
          user.username, user.phoneNumber, user.password);
    } catch (e) {}

    print('sent');
  }
}
