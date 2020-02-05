import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travel_guide/layouts/home_page.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            /// is because there is user already logged
            return MaterialApp(home: HomePage(),);
          }

          /// other way there is no user logged.
          return MaterialApp(
            home: LoginPage(),
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
        child: _buildLoginLayout(),
      ),
    );
  }

  Widget _buildLoginLayout() {
    return Stack(
      children: <Widget>[
        Background(),
        Align(
          alignment: Alignment.topCenter,
          child: AppLogo(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildLoginFields(),
        ),
      ],
    );
  }

  Widget _buildLoginFields() {
    return Container(
      margin: EdgeInsets.only(bottom: 80.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            _signInButton(),
            SizedBox(
              height: 10.0,
            ),
            _buildContinueWithoutSignInText(),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return Container(
        margin: EdgeInsets.only(right: 100, left: 100),
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {
            signInWithGoogle().whenComplete(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
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

  Widget _buildContinueWithoutSignInText() {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
