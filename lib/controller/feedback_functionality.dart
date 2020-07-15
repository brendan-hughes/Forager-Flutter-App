import 'package:flutter/material.dart';
import 'package:forageralpha/screens/email_login.dart';
import 'formatting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var dropdownValue = "QUESTION";
  var details = "";
  var errorTextDetails = "";
  var errorTextColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/forager3.png'), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 50,
            left: -10,
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                  width: 110,
                  child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    Text(" Back to Menu", style: descriptionTextSmall)
                  ])),
            ),
          ),
          SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color.fromRGBO(33, 33, 33, 0.6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("GET IN TOUCH", style: headerText),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: Text(
                                    "We love to receive feedback, suggestions, and questions from our users! Use the form below to get in touch with us. \n ",
                                    style: descriptionText,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Column(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(33, 33, 33, 0.4),
                                          border: Border.all(color:Color.fromRGBO(255, 255, 255, 0.5)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text("SELECT MESSAGE TYPE:",style:feedbackTextLight),SizedBox(width:20,),
                                          Container(
                                            width:100,
                                            child: DropdownButton(
                                            value: dropdownValue,
                                            style: feedbackTextLight,
                                            elevation: 20,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue = newValue;
                                              });
                                            },
                                            icon: Icon(Icons.arrow_drop_down_circle,color:Colors.white),
                                            items: <String>["QUESTION","FEEDBACK","ISSUE","OTHER"].map<DropdownMenuItem<String>>((String value) {return DropdownMenuItem<String>(value:value,child:Row(children: [Text(value, style: feedbackTextDark),SizedBox(width:15)]));}).toList(),
                                        ),
                                          ),],),
                                      ),
                                      SizedBox(height:20,),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.5)),
                                          color: Color.fromRGBO(33, 33, 33, 0.4),
                                        ),
                                        child: TextFormField(
                                          style: feedbackTextLight,
                                          cursorColor: Colors.indigo,
                                          keyboardType: TextInputType.multiline,
                                          onChanged: (value) {
                                            details = value;
                                          },
                                          maxLines: null,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                              hintText: "Type your message here.",
                                              hintStyle: feedbackTextLight,
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                Text(errorTextDetails, style: TextStyle(color:errorTextColor,fontFamily: 'GlacialRegular',
                                  fontSize: 12,), textAlign: TextAlign.center,),
                                RaisedButton(
                                  onPressed: () async {
                                    if (details == "") {
                                      setState(() {
                                        errorTextColor = Colors.red;
                                        errorTextDetails = "Please fill out message before sending.";
                                      });

                                    }
                                    else {
                                      await submitFeedback(
                                          dropdownValue, details);
                                      setState(() {
                                        errorTextColor = Colors.white;
                                        errorTextDetails = "Your message has been received.\n\n We typically respond within 1-2 business days.\n\n Thank you for Foraging! 😄";
                                      });
                                    }
                                  },
                                  elevation: 40.0,
                                  splashColor: Color.fromRGBO(75, 77, 94,1),
                                  color: Color.fromRGBO(33, 33, 33, 0.5),
                                  child: Text("CLICK TO SUBMIT",
                                      style: descriptionTextSmallBold),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(color: Colors.white)),
                                )
                              ],
                            ))),
                  ),
                ]),
          ),
        ]));
  }
}


submitFeedback (dropdownValue,details) async {
    final _firestore = Firestore.instance;
    final _auth = FirebaseAuth.instance;
    final user = await _auth.currentUser();
    final time = DateTime.now().toString();
    String userID = user.uid;
    await _firestore
        .collection('userFeedback')
        .document(userID + "-" + dropdownValue + "-" + time)
        .setData({
      "userID": userID,
      "type": dropdownValue,
      "timeSubmitted": time,
      "details": details,
      "resolved": false,
      "resolutionTime": null,
    });
}