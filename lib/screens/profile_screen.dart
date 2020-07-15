import 'package:flutter/material.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:forageralpha/controller/profile_functionality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
bool heightCM = true;
bool heightIN = false;
double heightValue = 180;
bool weightKG = true;
bool weightLB = false;
double weightValue = 70;
String birthDate = "Add Birthday";
bool male = true;
bool female = false;
bool vegetarian = false;
bool vegan = false;
bool ketogenic = false;
bool paleo = false;
bool lowSalt = false;
bool dairyFree = false;
bool lowSugar = false;
bool glutenFree = false;
bool balanced = false;
bool cleanEating = false;
bool highFiber = false;
bool highProtein = false;
bool lowCarb = false;
bool lowFat = false;
bool diabeticFriendly = false;
bool eggFree = false;
bool fishFree = false;
bool fodmapFree = false;
bool porkFree = false;
bool redMeatFree = false;
bool sesameFree = false;
bool shellfishFree = false;
bool soyFree = false;
bool treenutFree = false;
bool heartHealthy = false;
bool peanutFree = false;
double activityLevel;
bool sedentary;
bool lightActivity;
bool moderateActivity;
bool veryActive;

String userID;
double iconDimensions = 60;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeProfile(_auth, _firestore).then((result) {
      setState(() {
        heightCM = result['heightCM'];
        heightIN = result['heightIN'];

        if (heightIN == true) {
          heightValue =
              double.parse((result['heightValue'] / 2.54).toStringAsFixed(1));
          if (heightValue > 216) {
            heightValue = 216;
          }
        } else if (heightCM == true) {
          heightValue = result['heightValue'];
        }


        weightKG = result['weightKG'];
        weightLB = result['weightLB'];

        if (weightLB == true) {
          weightValue =
              double.parse((result['weightValue'] * 2.205).toStringAsFixed(1));
          if (weightValue > 300) {
            weightValue = 300;
          }
        } else if (weightKG == true) {
          weightValue = result['weightValue'];
        }

        birthDate = result['birthDate'];
        male = result['male'];
        female = result['female'];
        vegetarian = result['vegetarian'];
        vegan = result['vegan'];
        ketogenic = result['ketogenic'];
        paleo = result['paleo'];
        lowSalt = result['lowSalt'];
        dairyFree = result['dairyFree'];
        lowSugar = result['lowSugar'];
        glutenFree = result['glutenFree'];
        eggFree = result['eggFree'];
        fishFree = result['fishFree'];
        fodmapFree = result['fodmapFree'];
        balanced = result['balanced'];
        highFiber = result['highFiber'];
        highProtein = result['highProtein'];
        diabeticFriendly = result['diabeticFriendly'];
        lowCarb = result['lowCarb'];
        lowFat = result['lowFat'];
        cleanEating = result['cleanEating'];
        peanutFree = result['peanutFree'];
        porkFree = result['porkFree'];
        redMeatFree = result['redMeatFree'];
        sesameFree = result['sesameFree'];
        shellfishFree = result['shellfishFree'];
        soyFree = result['soyFree'];
        treenutFree = result['treenutFree'];
        heartHealthy = result['heartHealthy'];
        activityLevel = result['activityLevel'];

        if (activityLevel == 1.2) {
          sedentary = true;
          lightActivity = false;
          moderateActivity = false;
          veryActive = false;
        }
        if (activityLevel == 1.375) {
          sedentary = false;
          lightActivity = true;
          moderateActivity = false;
          veryActive = false;
        }
        if (activityLevel == 1.55) {
          sedentary = false;
          lightActivity = false;
          moderateActivity = true;
          veryActive = false;
        }
        if (activityLevel == 1.725) {
          sedentary = false;
          lightActivity = false;
          moderateActivity = false;
          veryActive = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/forager2.png'),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 40,
          left: -10,
          child: RaisedButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color.fromRGBO(33, 33, 33, 0.6),
                            ),
                            child: ListView(children: [
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("PROFILE SETTINGS",
                                        style: headerText),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "PERSONAL INFORMATION",
                                          style: secondaryHeaderText,
                                          textAlign: TextAlign.left,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text("Height:",
                                                      style: descriptionText),
                                                  SizedBox(width: 10),
                                                  Container(
                                                      width: 35,
                                                      child: Text(
                                                          heightValue
                                                              .toString(),
                                                          style:
                                                              secondaryHeaderText)),
                                                  SizedBox(width: 10),
                                                  Container(
                                                      width: 50,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: heightCM ==
                                                                  true
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.4)
                                                              : Colors
                                                                  .transparent,
                                                          child: Text("cm",
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () {
                                                            if (heightCM !=
                                                                true) {
                                                              setState(() {
                                                                heightCM = true;
                                                                heightIN =
                                                                    false;
                                                                heightValue =
                                                                    172;
                                                              });

                                                            }
                                                          })),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      width: 70,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: heightIN ==
                                                                  true
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.4)
                                                              : Colors
                                                                  .transparent,
                                                          child: Text("inches",
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () {
                                                            if (heightIN !=
                                                                true) {
                                                              setState(() {
                                                                heightIN = true;
                                                                heightCM =
                                                                    false;
                                                                heightValue =
                                                                    67;
                                                              });

                                                            }
                                                          })),
                                                ]),
                                            Slider(
                                              value: heightValue,
                                              min: heightIN == true ? 0 : 0,
                                              max: heightIN == true ? 85 : 216,
                                              divisions:
                                                  heightIN == true ? 85 : 216,
                                              activeColor: Colors.white,
                                              inactiveColor: Color.fromRGBO(
                                                  255, 255, 255, 0.4),
                                              onChanged: (value) {
                                                setState(() {
                                                  heightValue = value;
                                                  if (heightValue.toString().length > 5) {
                                                    heightValue = double.parse(heightValue.toStringAsFixed(1));
                                                  }
                                                });
                                              },
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text("Weight:",
                                                      style: descriptionText),
                                                  SizedBox(width: 10),
                                                  Container(
                                                      width: 35,
                                                      child: Text(
                                                          weightValue
                                                              .toString(),
                                                          style:
                                                              secondaryHeaderText)),
                                                  Container(
                                                      width: 45,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: weightKG ==
                                                                  true
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.4)
                                                              : Colors
                                                                  .transparent,
                                                          child: Text("kg",
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () {
                                                            if (weightKG !=
                                                                true) {
                                                              setState(() {
                                                                weightKG = true;
                                                                weightLB =
                                                                    false;
                                                                weightValue =
                                                                    70;
                                                              });

                                                            }
                                                          })),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      width: 50,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: weightLB ==
                                                                  true
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.4)
                                                              : Colors
                                                                  .transparent,
                                                          child: Text("lb",
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () {
                                                            if (weightLB !=
                                                                true) {
                                                              setState(() {
                                                                weightLB = true;
                                                                weightKG =
                                                                    false;
                                                                weightValue =
                                                                    150;
                                                              });

                                                            }
                                                          })),
                                                ]),
                                            Slider(
                                              value: weightValue.toDouble(),
                                              min: weightLB == true ? 0 : 0,
                                              max: weightLB == true ? 300 : 140,
                                              divisions:
                                                  weightLB == true ? 600 : 280,
                                              activeColor: Colors.white,
                                              inactiveColor: Color.fromRGBO(
                                                  255, 255, 255, 0.4),
                                              onChanged: (value) {
                                                setState(() {
                                                  weightValue = value;
                                                  if (weightValue.toString().length > 5) {
                                                    weightValue = double.parse(weightValue.toStringAsFixed(1));
                                                  }
                                                });
                                              },
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      top: 10,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text("Birthday:",
                                                      style: descriptionText),
                                                  SizedBox(width: 20),
                                                  Container(
                                                      width: 100,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child: Text(birthDate,
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () async {
                                                            final datePick = await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    new DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    new DateTime(
                                                                        1900),
                                                                lastDate:
                                                                    new DateTime(
                                                                        2100));
                                                            if (datePick !=
                                                                null) {
                                                              setState(() {
                                                                final birthDateData =
                                                                    datePick;
                                                                birthDate =
                                                                    "${birthDateData.month}/${birthDateData.day}/${birthDateData.year}";
                                                              });
                                                            }

                                                          })),
                                                ]),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text("Sex:",
                                                      style: descriptionText),
                                                  SizedBox(width: 20),
                                                  Container(
                                                      width: 70,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: male == true
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.4)
                                                              : Colors
                                                                  .transparent,
                                                          child: Text("Male",
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () {
                                                            if (male != true) {
                                                              setState(() {
                                                                male = true;
                                                                female = false;

                                                              });
                                                            }
                                                          })),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      width: 70,
                                                      height: 20,
                                                      child: FlatButton(
                                                          color: female == true
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.4)
                                                              : Colors
                                                                  .transparent,
                                                          child: Text("Female",
                                                              style:
                                                                  descriptionTextSmall),
                                                          onPressed: () {
                                                            if (female !=
                                                                true) {
                                                              setState(() {
                                                                female = true;
                                                                male = false;

                                                              });
                                                            }
                                                          })),
                                                ]),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "ACTIVITY LEVEL (Optional)",
                                          style: secondaryHeaderText,
                                          textAlign: TextAlign.left,
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 15.0, right: 15.0),
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      ClipOval(
                                                        child: Material(
                                                          color: sedentary ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent, // button color
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                    .blueGrey[
                                                                100], // inkwell color
                                                            child: SizedBox(
                                                                width:
                                                                    iconDimensions,
                                                                height:
                                                                    iconDimensions,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image(
                                                                      image: AssetImage(
                                                                          'lib/images/sedentary.png'),
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                )),
                                                            onTap: () {
                                                              if (sedentary !=
                                                                  true) {
                                                                setState(() {
                                                                  sedentary =
                                                                      true;
                                                                  lightActivity =
                                                                      false;
                                                                  moderateActivity =
                                                                      false;
                                                                  veryActive =
                                                                      false;
                                                                  activityLevel =
                                                                      1.2;

                                                                });
                                                              } else {
                                                                setState(() {
                                                                  sedentary =
                                                                      false;
                                                                  activityLevel =
                                                                      1;

                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Text("Sedentary",
                                                            style:
                                                                descriptionTextSmall),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      ClipOval(
                                                        child: Material(
                                                          color: lightActivity ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent, // button color
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                    .blueGrey[
                                                                100], // inkwell color
                                                            child: SizedBox(
                                                                width:
                                                                    iconDimensions,
                                                                height:
                                                                    iconDimensions,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image(
                                                                      image: AssetImage(
                                                                          'lib/images/light.png'),
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                )),
                                                            onTap: () {
                                                              if (lightActivity !=
                                                                  true) {
                                                                setState(() {
                                                                  lightActivity =
                                                                      true;
                                                                  sedentary =
                                                                      false;
                                                                  moderateActivity =
                                                                      false;
                                                                  veryActive =
                                                                      false;
                                                                  activityLevel =
                                                                      1.375;

                                                                });
                                                              } else {
                                                                setState(() {
                                                                  lightActivity =
                                                                      false;
                                                                  activityLevel =
                                                                      1;

                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Text(
                                                            "1 - 3 x Week",
                                                            style:
                                                                descriptionTextSmall),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      ClipOval(
                                                        child: Material(
                                                          color: moderateActivity ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent, // button color
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                    .blueGrey[
                                                                100], // inkwell color
                                                            child: SizedBox(
                                                                width:
                                                                    iconDimensions,
                                                                height:
                                                                    iconDimensions,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image(
                                                                      image: AssetImage(
                                                                          'lib/images/moderate.png'),
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                )),
                                                            onTap: () {
                                                              if (moderateActivity !=
                                                                  true) {
                                                                setState(() {
                                                                  moderateActivity =
                                                                      true;
                                                                  sedentary =
                                                                      false;
                                                                  lightActivity =
                                                                      false;
                                                                  veryActive =
                                                                      false;
                                                                  activityLevel =
                                                                      1.55;

                                                                });
                                                              } else {
                                                                setState(() {
                                                                  moderateActivity =
                                                                      false;
                                                                  activityLevel =
                                                                      1;

                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Text(
                                                            "4 - 5 x Week",
                                                            style:
                                                                descriptionTextSmall),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      ClipOval(
                                                        child: Material(
                                                          color: veryActive ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent, // button color
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                    .blueGrey[
                                                                100], // inkwell color
                                                            child: SizedBox(
                                                                width:
                                                                    iconDimensions,
                                                                height:
                                                                    iconDimensions,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image(
                                                                      image: AssetImage(
                                                                          'lib/images/veryactive.png'),
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                )),
                                                            onTap: () {
                                                              if (veryActive !=
                                                                  true) {
                                                                setState(() {
                                                                  veryActive =
                                                                      true;
                                                                  sedentary =
                                                                      false;
                                                                  lightActivity =
                                                                      false;
                                                                  moderateActivity =
                                                                      false;
                                                                  activityLevel =
                                                                      1.725;

                                                                });
                                                              } else {
                                                                setState(() {
                                                                  veryActive =
                                                                      false;
                                                                  activityLevel =
                                                                      1;

                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Text(
                                                            "> 6 x Week",
                                                            style:
                                                                descriptionTextSmall),
                                                      )
                                                    ],
                                                  ),
                                                ])
                                          ]))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 30),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "LIFESTYLE DIETS (Optional)",
                                          style: secondaryHeaderText,
                                          textAlign: TextAlign.left,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15.0, right: 15.0),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: balanced == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/balanced_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (balanced !=
                                                                true) {
                                                              setState(() {
                                                                balanced = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                balanced =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Balanced",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width:10),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: ketogenic == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/keto_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (ketogenic !=
                                                                true) {
                                                              setState(() {
                                                                ketogenic =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                ketogenic =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Ketogenic",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width:10),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: cleanEating == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/clean_eating.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (cleanEating !=
                                                                true) {
                                                              setState(() {
                                                                cleanEating = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                cleanEating = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Clean Eating",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),

                                              ]),
                                          SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: paleo == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/paleo_icon.png'),
                                                                    height:
                                                                    iconDimensions,
                                                                    width:
                                                                    iconDimensions),
                                                              )),
                                                          onTap: () {
                                                            if (paleo != true) {
                                                              setState(() {
                                                                paleo = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                paleo = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Paleo",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width:10),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: vegan == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/vegan_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (vegan != true) {
                                                              setState(() {
                                                                vegan = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                vegan = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Vegan",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width:10),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: vegetarian ==
                                                                true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/vegetarian_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (vegetarian !=
                                                                true) {
                                                              setState(() {
                                                                vegetarian =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                vegetarian =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Vegetarian",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                        ])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 30),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "DIETARY RESTRICTIONS (Optional)",
                                          style: secondaryHeaderText,
                                          textAlign: TextAlign.left,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15.0, right: 15.0),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: dairyFree == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/dairy_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (dairyFree !=
                                                                true) {
                                                              setState(() {
                                                                dairyFree =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                dairyFree =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Dairy Free",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: diabeticFriendly ==
                                                            true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/diabetic_friendly.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (diabeticFriendly !=
                                                                true) {
                                                              setState(() {
                                                                diabeticFriendly =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                diabeticFriendly =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text(
                                                          "Diabetic Friendly",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: eggFree == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/egg_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (eggFree !=
                                                                true) {
                                                              setState(() {
                                                                eggFree = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                eggFree = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Egg Free",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: fishFree == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/fish_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (fishFree !=
                                                                true) {
                                                              setState(() {
                                                                fishFree = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                fishFree =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Fish Free",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                          SizedBox(height: 20),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: glutenFree ==
                                                            true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/gluten_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (glutenFree !=
                                                                true) {
                                                              setState(() {
                                                                glutenFree =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                glutenFree =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Gluten Free",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: heartHealthy == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/heart_healthy.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (heartHealthy !=
                                                                true) {
                                                              setState(() {
                                                                heartHealthy =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                heartHealthy =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Heart Healthy",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: highFiber == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/highfiber_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (highFiber !=
                                                                true) {
                                                              setState(() {
                                                                highFiber =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                highFiber =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("High Fiber",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: highProtein ==
                                                            true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/highprotein_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (highProtein !=
                                                                true) {
                                                              setState(() {
                                                                highProtein =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                highProtein =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text(
                                                          "High Protein",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                          SizedBox(height: 20),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: lowCarb == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/lowcarb_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (lowCarb !=
                                                                true) {
                                                              setState(() {
                                                                lowCarb = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                lowCarb = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Low Carb",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: lowFat == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/lowfat_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (lowFat !=
                                                                true) {
                                                              setState(() {
                                                                lowFat = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                lowFat = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Low Fat",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: fodmapFree ==
                                                            true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/fodmap_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (fodmapFree !=
                                                                true) {
                                                              setState(() {
                                                                fodmapFree =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                fodmapFree =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Low FODMAP",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: lowSalt == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/salt_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (lowSalt !=
                                                                true) {
                                                              setState(() {
                                                                lowSalt = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                lowSalt = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Low Salt",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                          SizedBox(height: 20),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: lowSugar == true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/sugar_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (lowSugar !=
                                                                true) {
                                                              setState(() {
                                                                lowSugar = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                lowSugar =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Low Sugar",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: peanutFree ==
                                                            true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/peanut_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (peanutFree !=
                                                                true) {
                                                              setState(() {
                                                                peanutFree =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                peanutFree =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Peanut Free",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: porkFree == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/pork_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (porkFree !=
                                                                true) {
                                                              setState(() {
                                                                porkFree = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                porkFree =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Pork Free",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: redMeatFree ==
                                                                true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/redmeat_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (redMeatFree !=
                                                                true) {
                                                              setState(() {
                                                                redMeatFree =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                redMeatFree =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                          "Red Meat Free",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                          SizedBox(height: 20),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: sesameFree ==
                                                            true
                                                            ? Colors.white
                                                            : Colors
                                                            .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                              iconDimensions,
                                                              height:
                                                              iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/sesame_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (sesameFree !=
                                                                true) {
                                                              setState(() {
                                                                sesameFree =
                                                                true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                sesameFree =
                                                                false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text("Sesame Free",
                                                          style:
                                                          descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: shellfishFree ==
                                                                true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/shellfish_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (shellfishFree !=
                                                                true) {
                                                              setState(() {
                                                                shellfishFree =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                shellfishFree =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                          "Shellfish Free",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: soyFree == true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/soy_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (soyFree !=
                                                                true) {
                                                              setState(() {
                                                                soyFree = true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                soyFree = false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text("Soy Free",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: treenutFree ==
                                                                true
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent, // button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                                  .blueGrey[
                                                              100], // inkwell color
                                                          child: SizedBox(
                                                              width:
                                                                  iconDimensions,
                                                              height:
                                                                  iconDimensions,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'lib/images/treenut_icon.png'),
                                                                    height: 20,
                                                                    width: 20),
                                                              )),
                                                          onTap: () {
                                                            if (treenutFree !=
                                                                true) {
                                                              setState(() {
                                                                treenutFree =
                                                                    true;

                                                              });
                                                            } else {
                                                              setState(() {
                                                                treenutFree =
                                                                    false;

                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                          "Tree Nut Free",
                                                          style:
                                                              descriptionTextSmall),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                          SizedBox(height: 30)
                                        ])),
                                  ),
                                ],
                              ),
                            ]))),
                  ),
                  RaisedButton(
                    onPressed: () => saveProfile(
                      _auth,
                      context,
                      heightCM,
                      heightIN,
                      heightValue,
                      weightKG,
                      weightLB,
                      weightValue,
                      birthDate,
                      male,
                      female,
                      vegetarian,
                      vegan,
                      ketogenic,
                      paleo,
                      lowSalt,
                      dairyFree,
                      lowSugar,
                      glutenFree,
                      eggFree,
                      fishFree,
                      fodmapFree,
                      highFiber,
                      highProtein,
                      diabeticFriendly,
                      lowCarb,
                      lowFat,
                      cleanEating,
                      balanced,
                      peanutFree,
                      porkFree,
                      redMeatFree,
                      sesameFree,
                      shellfishFree,
                      soyFree,
                      treenutFree,
                      heartHealthy,
                      activityLevel,
                    ),
                    elevation: 40.0,
                    color: Color.fromRGBO(33, 33, 33, 0.5),
                    child: Container(
                      width: 125,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.settings, color: Colors.white),
                            Text(" SAVE SETTINGS", style: descriptionTextSmallBold),
                          ]),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white)),
                  ),
                ]),
              ]),
        ),
      ],
    ));
  }
}
