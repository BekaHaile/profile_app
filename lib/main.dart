import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/Home.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: WelcomeScreen(),
        routes: {
          '/welcome': (BuildContext context) => WelcomeScreen(),
          '/signUp': (BuildContext context) => SignUpScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/home': (BuildContext context) => Home()
        },
        onGenerateRoute: (RouteSettings settings) {
          // final requests = settings.arguments;

          switch (settings.name) {
            case '/phoneNo':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen(
                      // type: requests,
                      ));
            default:
              return null;
          }
        });
  }
}
