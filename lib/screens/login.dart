import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lembrete/screens/home.dart';
import 'package:lembrete/services/auth_service.dart';
import 'package:lembrete/widgets/google_sign_in_button.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<GoogleSignInAccount> _googleSignInAccount;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount> _signInSilently() async {
    final GoogleSignInAccount account = await _googleSignIn.signInSilently();

    if (account != null) {
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      await AuthService.googleSignIn(authentication.idToken);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }

    return account;
  }

  Widget _getPageContent(AsyncSnapshot<GoogleSignInAccount> snapshot) {
    if (snapshot.connectionState == ConnectionState.done &&
        snapshot.data == null) {
      return GoogleSignInButton();
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    _googleSignInAccount = _signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: Text('Login')),
      body: FutureBuilder<GoogleSignInAccount>(
          future: _googleSignInAccount,
          builder: (BuildContext context,
              AsyncSnapshot<GoogleSignInAccount> snapshot) {
            return Column(children: [
              Expanded(
                  child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 0),
                  child: Image(image: AssetImage('assets/logo.png')),
                ),
              )),
              Expanded(
                  child: Align(
                      alignment: Alignment(0, -1.125),
                      child: _getPageContent(snapshot)))
            ]);
          }),
    );
  }
}
