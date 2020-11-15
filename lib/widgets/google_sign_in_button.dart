import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lembrete/screens/home.dart';

class GoogleSignInButton extends StatelessWidget {
  Future<void> _signIn(BuildContext context) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await account?.authentication;

      // TODO: call API to save data

      if (authentication != null) {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    } catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, padding: EdgeInsets.all(8), elevation: 10),
        onPressed: () => _signIn(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Sign in with Google',
                style: TextStyle(fontSize: 16.0, color: Colors.grey.shade900),
              ),
            )
          ],
        ));
  }
}
