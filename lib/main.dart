import 'package:flutter/material.dart';
import 'package:forageralpha/screens/new_profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/find_a_food_screen.dart';
import 'screens/forgot_screen.dart';
import 'screens/email_login.dart';
import 'screens/find_a_food_results_screen.dart';
import 'controller/feedback_functionality.dart';
import 'screens/favorite_screen.dart';
import 'screens/details_screen.dart';
import 'controller/find_food_functionality.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ForagerMain());
}

class ForagerMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      initialRoute: "/login",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/email': (context) => EmailLoginScreen(),
        '/main': (context) => MainScreen(),
        '/profile': (context) => ProfileScreen(),
        '/findafood': (context) => FindAFoodScreen(),
        '/newprofile': (context) => NewProfileScreen(),
        '/addcondition': (context) => AddConditionDialog(),
        '/findafoodresults' : (context) => FindAFoodResultScreen(),
        '/details' : (context) => DetailsScreen(),
        '/favorites' : (context) => FavoriteScreen(),
        '/feedback' : (context) => FeedbackScreen(),
        '/forgot' : (context) => ForgotScreen(),
      },
    );
  }
}
