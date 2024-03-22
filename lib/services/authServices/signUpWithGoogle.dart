import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lekhny/ui/screens/bottomNavigationBarScreen.dart';
import 'package:lekhny/ui/screens/loginScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lekhny/viewModel/authViewModel.dart';
import 'package:provider/provider.dart';

class SignUpWithGoogle{
  //1. handleAuthState

  //2. signInWithGoogle

  //3. signOut

  // determine if the user is authenticated.

  handleAuthState(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot){
          if (snapshot.hasData){
            return BottomNavigationBarScreen();
          }else{
            return LoginScreen();
          }
        }
    );
  }

  signInWithGoogle(context)async{

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"]).signIn();

    // obtain the auth details from the request

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    //once signed in, return the userCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value){

      Map data = {
        "email" : FirebaseAuth.instance.currentUser!.email.toString(),
        "socailId" : googleAuth.idToken.toString(),
        "name" : FirebaseAuth.instance.currentUser!.displayName.toString(),
      };

      print(" this is login by social data ${data}");

      authViewModel.signUpByGoogle(data, context);


    });
  }

  logInWithGoogle(context)async{

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // obtain the auth details from the request

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    //once signed in, return the userCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value){

      print("this is googleAuth.idToken.toString() ${googleAuth.idToken.toString()}");

      Map data = {
        "email" : FirebaseAuth.instance.currentUser!.email.toString(),
        "socailId" : googleAuth.idToken.toString(),
      };

      print(" this is login by social data ${data}");

      authViewModel.loginByGoogle(data, context);


    });
  }

  Future<void> signOut()async{

    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

  }

}