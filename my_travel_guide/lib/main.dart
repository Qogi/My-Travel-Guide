import 'package:flutter/material.dart';
import 'package:my_travel_guide/home_page.dart';
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
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
            _buildGoogleSignInButton(),
            SizedBox(
              height: 10.0,
            ),
            _buildContinueWithoutSignInText(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return Container(
      margin: EdgeInsets.only(right: 100, left: 100),
      child: RaisedButton(
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())),
        color: Colors.white,
        child: Text(
          'Google Sign In',
          style: TextStyle(color: Colors.black),
        ),
      ));
  }

  Widget _buildContinueWithoutSignInText() {
    return Text(
      'Continue without signing in',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: 150.0,
      height: 150.0,
      decoration:
      BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo_white.png'),
        )
      ),

    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sign_in_page_bg.jpg'),
            fit: BoxFit.fill
          )
      ),

    );
  }
}