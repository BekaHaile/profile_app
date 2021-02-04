import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/services/repository.dart';
import 'package:flutter_auth/services/sqlite.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name = '';
    String phone = '';
    String city = '';
    String username = '';
    String password = '';
    String bankName = '';
    String accountNumber = '';

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.04),
              Text(
                "Register",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Name",
                onChanged: (value) {
                  name = value;
                },
                icon: Icons.person,
              ),
              RoundedInputField(
                hintText: "City",
                onChanged: (value) {
                  city = value;
                },
                icon: Icons.location_city,
              ),
              RoundedInputField(
                hintText: "Bank name",
                onChanged: (value) {
                  bankName = value;
                },
                icon: Icons.face,
              ),
              RoundedInputField(
                hintText: "Account Number",
                onChanged: (value) {
                  accountNumber = value;
                },
                icon: Icons.face,
              ),
              RoundedInputField(
                hintText: "Phone Number",
                onChanged: (value) {
                  phone = value;
                },
                icon: Icons.phone,
              ),
              RoundedInputField(
                hintText: "Username",
                onChanged: (value) {
                  username = value;
                },
                icon: Icons.face,
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "Register",
                press: () async {
                  final cryptor = new PlatformStringCryptor();
                  // final String salt = await cryptor.generateSalt();
                  final String key =
                      'y0jdPPV4WCNqmjSSeWitkw==:FoDyZyiP8O3R83DA4azmhntVuyOe4p600P+8DCn+N2I=';
                  final String encrypted = await cryptor.encrypt(password, key);
                  final decrypted = await cryptor.decrypt(encrypted, key);

                  print('The decrypted key is - $decrypted');

                  User user = User(
                      firstName: name,
                      city: city,
                      phoneNumber: phone,
                      username: username,
                      password: encrypted,
                      bankName: bankName,
                      accountNumber: accountNumber);
                  await Repository().registerUser(context, user);
                  Sqlite sqlite = Sqlite();

                  print('is being saved**********' +
                      user.username +
                      user.password);

                  sqlite.save(user);
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
