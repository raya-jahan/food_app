import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_delivery_app/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food_delivery_app/controllers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late UserProvider userProvider;
  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
        currentUser: user!,
        userEmail: user.email!,
        userImage: user.photoURL!,
        userName: user.displayName!,
      );

      return user;
    } catch (e) {
      //print(e.message);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/background1.jpg'))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 400,
                    width: double.infinity,
                    //color: Colors.white70,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(' Sign in to continue',
                            style: TextStyle(
                                height: 5,
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.green.shade900,
                                    offset: Offset(3, 3),
                                  )
                                ])),
                        SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          onPressed: () async {
                            await _googleSignUp().then(
                              (value) => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          'By signing in you are agreeing to our',
                          style: TextStyle(
                            height: 5,
                            color: Colors.grey[200],
                          ),
                        ),
                        Text(
                          'Terms and Pricacy Policy',
                          style: TextStyle(
                            color: Colors.grey[200],
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }
}
