import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/services/sqlite.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String username = '';
    String password = '';
    bool obscure = true;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                username = value;
              },
              icon: Icons.face,
            ),
            RoundedPasswordField(
              obscure: obscure,
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                final cryptor = new PlatformStringCryptor();
                // final String salt = await cryptor.generateSalt();
                final String key =
                    'y0jdPPV4WCNqmjSSeWitkw==:FoDyZyiP8O3R83DA4azmhntVuyOe4p600P+8DCn+N2I=';

                Sqlite sqlite = Sqlite();
                User user = User();

                user = await sqlite.getUsers();

                if (user != null) {
                  print(user.username);
                  final decrypted = await cryptor.decrypt(user.password, key);

                  print(
                      'about to check $username == ${user.username} // $decrypted == $password');

                  if (user.username == username && password == decrypted) {
                    print('userFound');
                    Navigator.pushNamed(context, '/home');
                  } else {
                    showSnackBar(context);
                  }
                } else {
                  print('No user has been saved');
                  showSnackBar(context);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  showSnackBar(context) async {
    Flushbar(
      padding: EdgeInsets.all(20),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
          colors: [Colors.red.shade800, Colors.red.shade700], stops: [0.6, 1]),
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Error',
      message: 'Credential Mismatch',
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
