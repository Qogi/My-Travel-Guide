import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travel_guide/layouts/home_page.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';
import 'package:my_travel_guide/firebase/user_timeline_landmarks.dart';

main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MyApp(),
      '/home': (BuildContext context) => new HomePage()
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            /// is because there is user already logged
            return Scaffold(
              body: HomePage(),
            );
          }

          /// other way there is no user logged.
          return Scaffold(
            body: LoginPage(),
          );
        });
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      child: _buildLoginLayout(
        context,
      ),
    ));
  }

  Widget _buildLoginLayout(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(),
        Align(
          alignment: Alignment.topCenter,
          child: AppLogo(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildLoginFields(context),
        ),
      ],
    );
  }

  Widget _buildLoginFields(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 80.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            _signInButton(context),
            SizedBox(
              height: 10.0,
            ),
            _buildContinueWithoutSignInText(context),
          ],
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext buildContext) {
    return Container(
        margin: EdgeInsets.only(right: 85, left: 80),
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {
            signInWithGoogle().whenComplete(() {
              getData();
              Navigator.of(buildContext).popAndPushNamed('/home');
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          highlightElevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("assets/images/google_logo.png"),
                    height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildContinueWithoutSignInText(BuildContext buildContext) {
    return InkWell(
        onTap: () {
          Navigator.push(buildContext,
              MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text(
          'Continue without signing in',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }
}

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo_white.png'),
      )),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/sign_in_page_bg.jpg'),
              fit: BoxFit.fill)),
    );
  }
}
