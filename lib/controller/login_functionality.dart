import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


//Facebook Widget
class CustomWebView extends StatefulWidget {
  final String selectedUrl;

  CustomWebView({this.selectedUrl});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("#access_token")) {
        succeed(url);
      }

      if (url.contains(
          "https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
        denied();
      }
    });
  }

  denied() {
    Navigator.pop(context);
  }

  succeed(String url) {
    var params = url.split("access_token=");

    var endparam = params[1].split("&");

    Navigator.pop(context, endparam[0]);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.selectedUrl,
        clearCache: true,
        clearCookies: true,
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(66, 103, 178, 1),
          title: new Text("Facebook Login"),
        ));
  }
}

//Email Login Logic
emailLogIn(context, _auth, email, password) async {
    //First trying to make a new user with the email and password.
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (newUser != null) {
      try
      {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          return true;
        }
      }
      catch (e) {return false;}
    }
    }
    catch (e) {
      try
      {
        final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          if (user != null) {
            return true;
          }
      }
      catch (e) {return false;}
    }

    }

forgotPass(email) async {
  final _firebaseAuth = FirebaseAuth.instance;
  await _firebaseAuth.sendPasswordResetEmail(email: email);
}


//Facebook Login Logic
loginWithFacebook(context, _saving, _auth, setState) async {
  String fbClientId = '536439553969760';
  String fbRedirectUrl = 'https://www.facebook.com/connect/login_success.html';
  String result = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => CustomWebView(
              selectedUrl:
                  'https://www.facebook.com/dialog/oauth?client_id=$fbClientId&redirect_uri=$fbRedirectUrl&response_type=token&scope=email,public_profile,',
            ),
        maintainState: true),
  );

  if (result != null) {
    try {
      final facebookAuthCred =
          FacebookAuthProvider.getCredential(accessToken: result);
      final user = await _auth.signInWithCredential(facebookAuthCred);
      if (user != null) {
        directUserFlow(context);
      }
    } catch (e) {}
  }
}

//Google Login Logic
loginWithGoogle(context, _saving, _auth, setState) async {
  final _googleSignIn = GoogleSignIn(scopes: ['email']);
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuthentication =
        await googleUser.authentication;
    setState(() {
      _saving = true;
    });

    if (googleUser != null) {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken);
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      if (user != null) {
        directUserFlow(context);
      }
    }
  } catch (e) {
  }
}

//Check User Status on Sign In - Direct to Profile or Main
directUserFlow(context) async {
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  final userID = user.uid;
  final userQuery = await Firestore.instance
      .collection('userData')
      .document(userID).get();
  bool userExists = userQuery.exists;
  //If Returning User - if userID is in database already, send to main.
  if (userExists == true) {
    Navigator.pushNamed(context, '/main');
  }
  //If New User - if user ID wasn't in database, add it to the database and send to new profile page.
  else if (userExists == false) {
    Firestore.instance.collection('userData').document(userID).setData({'userID': userID});
    Navigator.pushNamed(context, '/newprofile');
  }
}
