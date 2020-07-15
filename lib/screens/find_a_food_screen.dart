import 'package:flutter/material.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:forageralpha/controller/find_food_functionality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forageralpha/controller/forage_functionality.dart';
import 'package:forageralpha/controller/mongo.dart';

Color individualFoodsBtn = Color.fromRGBO(255, 255, 255, 0.4);
Map _conditions = {
  //Nutritional
  "calorieConditions": ['Calories',null],
  "carbohydrateConditions": ['Carbohydrates',null],
  "ingredientConditions": ['Ingredients',null],
  "fatConditions": ['Fat',null],
  "proteinConditions": ['Protein',null],
  'calciumConditions': ['Calcium',null],
  'cholesterolConditions': ['Cholesterol',null],
  'monounsaturatedConditions': ['MonounsaturatedFat',null],
  'polyunsaturatedConditions': ['PolyunsaturatedFat',null],
  'saturatedConditions': ['SaturatedFat',null],
  'transConditions': ['TransFat',null],
  'ironConditions': ['Iron',null],
  'fiberConditions': ['Fiber',null],
  'folateConditions': ['Folate',null],
  'potassiumConditions': ['Potassium',null],
  'magnesiumConditions': ['Magnesium',null],
  'sodiumConditions': ['Sodium',null],
  'niacinb3Conditions': ['VitaminB3',null],
  'phosphorusConditions': ['Phosphorus',null],
  'riboflavinb2Conditions': ['VitaminB2',null],
  'sugarsConditions': ['Sugar',null],
  'thiaminb1Conditions': ['VitaminB1',null],
  'vitamineConditions': ['VitaminE',null],
  'vitaminaConditions': ['VitaminA',null],
  'vitaminb12Conditions': ['VitaminB12',null],
  'vitaminb6Conditions': ['VitaminB6',null],
  'vitamincConditions': ['VitaminC',null],
  'vitamindConditions': ['VitaminD',null],
  'vitaminkConditions': ['VitaminK',null],
  //Dietary
  'diabeticFriendlyConditions':['Diabetic',null],
  'heartHealthyConditions':['Heart-Healthy Recipes',null],
  'highFiberConditions':['High Fiber Recipes',null],
  'highProteinConditions':['High Protein',null],
  'lowCarbConditions':['Low Carb Recipes',null],
  'lowFatConditions':['Low Fat',null],
  'lowFODMAPConditions':['Low FODMAP',null],
  'glutenFreeConditions': ['Gluten Free',null],
  'ketogenicConditions': ['Ketogenic',null],
  'dairyFreeConditions': ['Dairy Free Recipes',null],
  'lowSaltConditions': ['Low Salt',null],
  'lowSugarConditions': ['Low Sugar',null],
  'paleoConditions': ['Paleo',null],
  'veganConditions': ['Vegan',null],
  'vegetarianConditions': ['Vegetarian',null],
  'eggFreeConditions': ['Egg Free',null],
  'fishFreeConditions': ['Fish Free',null],
  'balancedConditions': ['Healthy',null],
  'cleanEatingConditions': ['Clean Eating',null],
  'peanutFreeConditions':['Peanut Free',null],
  'porkFreeConditions':['Pork Free',null],
  'redMeatFreeConditions':['Red Meat Free',null],
  'sesameFreeConditions':['Sesame Free',null],
  'shellfishFreeConditions':['Shellfish Free',null],
  'soyFreeConditions':['Soy Free',null],
  'treenutFreeConditions':['Tree Nut Free',null],
  //Dishes
  'breadsDishCondition':['Bread Recipes',null],
  'cakesDishCondition':['Cake Recipes',null],
  'candyDishCondition':['Candy and Fudge',null],
  'casseroleDishCondition':['Casserole Recipes',null],
  'cocktailDishCondition':['Cocktail Recipes',null],
  'cookieDishCondition':['Cookie Recipes',null],
  'macandcheeseDishCondition':['Mac and Cheese Recipes',null],
  'mainDishesCondition':['Main Dishes',null],
  'pastaSaladDishCondition':['Pasta Salad Recipes',null],
  'pastaDishCondition': ['Pasta Recipes',null],
  'pieDishCondition':['Pie Recipes',null],
  'pizzaDishCondition':['Pizza',null],
  'sandwichDishCondition':['Sandwiches',null],
  'saucesDishCondition':['Sauces and Condiments',null],
  'smoothiesDishCondition':['Smoothie Recipes',null],
  'soupsDishCondition':['Soups',null],
  'bbqDishCondition':['BBQ & Grilling',null],
  'kidsDishCondition':['Cooking For Kids',null],
  'forTwoDishCondition':['Cooking for Two',null],
  'budgetDishCondition':['Budget Cooking',null],
  'pressureCookerDishCondition':['Pressure Cooker',null],
  'quickEasyDishCondition':['Quick & Easy',null],
  'slowCookerDishCondition' : ['Slow Cooker',null],
  //Meal type
  'breakfastAndBrunchConditions' : ['Breakfast and Brunch',null],
  'dinnerConditions' : ['Dinners',null],
  'dessertsConditions': ['Desserts',null],
  'lunchConditions': ['Lunch',null],
  'entertainingPartiesConditions': ['Entertaining and Dinner Parties',null],
  //Cuisines
  'africanConditions': ['African',null],
  'americanConditions': ['American',null],
  'argentinianConditions': ['Argentenian',null],
  'australianConditions': ['Australian',null],
  'austrianConditions': ['Austrian',null],
  'bangladeshiConditions': ['Bangladeshi',null],
  'belgianConditions': ['Belgian',null],
  'brazilianConditions': ['Brazilian',null],
  'canadianConditions': ['Canadian',null],
  'chileanConditions': ['Chilean',null],
  'chineseConditions': ['Chinese',null],
  'colombianConditions': ['Colombian',null],
  'cubanConditions': ['Cuban',null],
  'dutchConditions': ['Dutch',null],
  'easternEuropeanConditions': ['Eastern European',null],
  'filipinoConditions': ['Filipino',null],
  'frenchConditions': ['French',null],
  'germanConditions': ['German',null],
  'greekConditions': ['Greek',null],
  'indianConditions': ['Indian',null],
  'indonesianConditions': ['Indonesian',null],
  'israeliConditions': ['Israeli',null],
  'italianConditions': ['Italian',null],
  'jamaicanConditions': ['Jamaican',null],
  'japaneseConditions': ['Japanese',null],
  'koreanConditions': ['Korean',null],
  'lebaneseConditions': ['Lebanese',null],
  'malaysianConditions': ['Malaysian',null],
  'mediterraneanConditions': ['Mediterranean',null],
  'mexicanConditions': ['Mexican',null],
  'pakistaniConditions': ['Pakistani',null],
  'persianConditions': ['Persian',null],
  'peruvianConditions': ['Peruvian',null],
  'portugueseConditions': ['Portuguese',null],
  'puertoRicanConditions': ['Puerto Rican',null],
  'scandinavianConditions': ['Scandinavian',null],
  'southernConditions': ['Southern',null],
  'spanishConditions': ['Spanish',null],
  'swissConditions': ['Swiss',null],
  'thaiConditions': ['Thai',null],
  'turkishConditions': ['Turkish',null],
  'ukIrishConditions': ['UK & Irish',null],
  'vietnameseConditions': ['Vietnamese',null],
};
bool isLoading = false;
Color recipesBtn = Colors.transparent;
final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
final circleBack = Color.fromRGBO(75, 77, 94, 1);
final circleFront = Color.fromRGBO(196, 200, 224, 1);
bool selectedIndividualFoods = false;
bool selectedRecipes = true;
bool vegetarian = false;
bool vegan = false;
bool ketogenic = false;
bool paleo = false;
bool lowSalt = false;
bool lowSugar = false;
bool dairyFree = false;
bool glutenFree = false;
bool balanced = false;
bool cleanEating = false;
bool pescatarian = false;
bool highFiber = false;
bool highProtein = false;
bool lowCarb = false;
bool lowFat = false;
bool diabeticFriendly = false;
bool eggFree = false;
bool fishFree = false;
bool lowFODMAP = false;
bool porkFree = false;
bool redMeatFree = false;
bool sesameFree = false;
bool shellfishFree = false;
bool soyFree = false;
bool treenutFree = false;
bool heartHealthy = false;
bool peanutFree = false;
int defaultSettingLength = 0;
bool dietStatement = false;
bool defaultStatement = true;
var sessionID;

class FindAFoodScreen extends StatefulWidget {
  @override
  _FindAFoodScreenState createState() => _FindAFoodScreenState();
}

class _FindAFoodScreenState extends State<FindAFoodScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeFindFood(_auth, _firestore).then((result) {
      setState(() {
        isLoading = false;
        defaultSettingLength = 0;
        selectedIndividualFoods = false;
        selectedRecipes = true;
        vegetarian = result['vegetarian'];
        vegan = result['vegan'];
        ketogenic = result['ketogenic'];
        paleo = result['paleo'];
        lowSalt = result['lowSalt'];
        lowSugar = result['lowSugar'];
        dairyFree = result['dairyFree'];
        glutenFree = result['glutenFree'];
        eggFree = result['eggFree'];
        fishFree = result['fishFree'];
        lowFODMAP = result['lowFODMAP'];
        balanced = result['balanced'];
        highFiber = result['highFiber'];
        highProtein = result['highProtein'];
        diabeticFriendly = result['diabeticFriendly'];
        lowCarb = result['lowCarb'];
        lowFat = result['lowFat'];
        pescatarian = result['pescatarian'];
        cleanEating = result['cleanEating'];
        peanutFree = result['peanutFree'];
        porkFree = result['porkFree'];
        redMeatFree = result['redMeatFree'];
        sesameFree = result['sesameFree'];
        shellfishFree = result['shellfishFree'];
        soyFree = result['soyFree'];
        treenutFree = result['treenutFree'];
        heartHealthy = result['heartHealthy'];

        if (vegetarian == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("vegetarian", vegetarian);
        }
        if (vegan == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("vegan", vegan);
        }
        if (ketogenic == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("ketogenic", ketogenic);
        }
        if (paleo == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("paleo", paleo);
        }
        if (lowSalt == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("lowSalt", lowSalt);
        }
        if (lowSugar == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("lowSugar", lowSugar);
        }
        if (dairyFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("dairyFree", dairyFree);
        }
        if (glutenFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition("glutenFree", glutenFree);
        }
        if (eggFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('eggFree', eggFree);
        }
        if (fishFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('fishFree', fishFree);
        }
        if (lowFODMAP == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('lowFODMAP', lowFODMAP);
        }
        if (balanced == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('balanced', balanced);
        }
        if (highFiber == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('highFiber', highFiber);
        }
        if (highProtein == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('highProtein', highProtein);
        }
        if (diabeticFriendly == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('diabeticFriendly', diabeticFriendly);
        }
        if (lowCarb == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('lowCarb', lowCarb);
        }
        if (lowFat == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('lowFat', lowFat);
        }
        if (pescatarian == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('pescatarian', pescatarian);
        }
        if (cleanEating == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('cleanEating', cleanEating);
        }
        if (peanutFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('peanutFree', peanutFree);
        }
        if (porkFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('porkFree', porkFree);
        }
        if (redMeatFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('redMeatFree', redMeatFree);
        }
        if (sesameFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('sesameFree', sesameFree);
        }
        if (shellfishFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('shellfishFree', shellfishFree);
        }
        if (soyFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('soyFree', soyFree);
        }
        if (treenutFree == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('treenutFree', treenutFree);
        }
        if (heartHealthy == true) {
          defaultSettingLength = defaultSettingLength + 1;
          submitCondition('heartHealthy', heartHealthy);
        }
        if (defaultSettingLength == 0) {
          defaultStatement = false;
        } else if (defaultSettingLength > 0) {
          defaultStatement = true;
        }
      });
    });

    checkSessionID().then((result) {
      setState(() {
        sessionID = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
              ))
            : null,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/images/forager2.png'), fit: BoxFit.cover),
        ),
      ),
      Positioned(
        top: 50,
        left: -10,
        child: RaisedButton(
          onPressed: () {
            endSession(sessionID, context);
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
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(children: [
                            SizedBox(height: 12),
                            Column(
                              children: <Widget>[
                                Text("FIND FOOD", style: headerText),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 10),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(children: [
//                                        Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceAround,
//                                          children: <Widget>[
////                                            Container(
////                                              width: 57,
////                                              child: Text(
////                                                "INCLUDE:",
////                                                style: descriptionTextBoldSmall,
////                                                textAlign: TextAlign.left,
////                                              ),
////                                            ),
////                                            Container(
////                                                width: 110,
////                                                height: 30,
////                                                decoration: selectedRecipes == true ? BoxDecoration(border:Border.all(color: Colors.white,width:2.0),borderRadius: BorderRadius.circular(10)) : BoxDecoration(border:Border.all(color: Color.fromRGBO(255,255,255,0.2),width:2.0),borderRadius: BorderRadius.circular(10)),
////                                                child: FlatButton(
////                                                    color: selectedRecipes ==
////                                                            true
////                                                        ? Color.fromRGBO(
////                                                            255, 255, 255, 0.35)
////                                                        : Colors.transparent,
////                                                    child: Row(
////                                                        mainAxisAlignment:
////                                                            MainAxisAlignment
////                                                                .center,
////                                                        children: [
////                                                          Image(
////                                                            image: AssetImage(
////                                                                'lib/images/cookbook.png'),
////                                                            height: 25,
////                                                          ),
////                                                          SizedBox(
////                                                            width: 5,
////                                                          ),
////                                                          Text("Recipes",
////                                                              style:
////                                                                  descriptionTextSmall),
////                                                        ]),
////                                                    onPressed: () {
////                                                      if (selectedRecipes ==
////                                                          false) {
////                                                        setState(() {
////                                                          selectedRecipes =
////                                                              true;
////                                                          selectedIndividualFoods =
////                                                              false;
////                                                        });
////                                                      }
////                                                      submitCondition("recipes",
////                                                          selectedRecipes);
////                                                      submitCondition(
////                                                          "individualFoods",
////                                                          selectedIndividualFoods);
////                                                    })),
//                                            Container(
//                                                width: 150,
//                                                height: 30,
//                                                decoration: selectedIndividualFoods == true ? BoxDecoration(border:Border.all(color: Colors.white,width:2.0),borderRadius: BorderRadius.circular(10)) : BoxDecoration(border:Border.all(color: Color.fromRGBO(255,255,255,0.2),width:2.0),borderRadius: BorderRadius.circular(10)),
//                                                child: FlatButton(
//                                                    color:
//                                                        selectedIndividualFoods ==
//                                                                true
//                                                            ? Color.fromRGBO(
//                                                                255,
//                                                                255,
//                                                                255,
//                                                                0.35)
//                                                            : Colors
//                                                                .transparent,
//                                                    child: Row(children: [
//                                                      Image(
//                                                        image: AssetImage(
//                                                            'lib/images/corn.png'),
//                                                        height: 25,
//                                                      ),
//                                                      SizedBox(
//                                                        width: 5,
//                                                      ),
//                                                      Text("Individual Foods",
//                                                          style:
//                                                              descriptionTextSmall),
//                                                    ]),
//                                                    onPressed: () {
//                                                      if (selectedIndividualFoods ==
//                                                          false) {
//                                                        setState(() {
//                                                          selectedIndividualFoods =
//                                                              true;
//                                                          selectedRecipes =
//                                                              false;
//                                                        });
//                                                      }
//                                                      submitCondition("recipes",
//                                                          selectedRecipes);
//                                                      submitCondition(
//                                                          "individualFoods",
//                                                          selectedIndividualFoods);
//                                                    })),
//                                          ],
//                                        ),
                                      ])),
                                ),
                                if (defaultStatement == true)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 30),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "DEFAULT PROFILE CONDITIONS",
                                          style: secondaryHeaderText,
                                          textAlign: TextAlign.left,
                                        )),
                                  ),
                                if (defaultStatement == true)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Column(
                                      children: [
                                        if (defaultSettingLength == 0)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (defaultSettingLength == 0)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.refresh,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          Navigator
                                                              .popAndPushNamed(
                                                                  context,
                                                                  '/findafood');
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Removed all preferences. Click to refresh.",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (eggFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (eggFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          eggFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'eggFree', eggFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Egg Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (fishFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (fishFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          fishFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;

                                                        });
                                                        submitCondition(
                                                            'fishFree',
                                                            fishFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Fish Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (lowFODMAP == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (lowFODMAP)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          lowFODMAP = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;

                                                        });
                                                        submitCondition(
                                                            'lowFODMAP',
                                                            lowFODMAP);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Low FODMAP',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (balanced == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (balanced)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          balanced = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;

                                                        });
                                                        submitCondition(
                                                            'balanced',
                                                            balanced);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Balanced',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (highFiber == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (highFiber)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          highFiber = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'highFiber',
                                                            highFiber);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'High Fiber',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (highProtein == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (highProtein)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          highProtein = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'highProtein',
                                                            highProtein);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'High Protein',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (diabeticFriendly == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (diabeticFriendly)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          diabeticFriendly =
                                                              false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'diabeticFriendly',
                                                            diabeticFriendly);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Diabetic Friendly',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (lowCarb == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (lowCarb)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          lowCarb = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'lowCarb', lowCarb);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Low Carb',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (lowFat == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (lowFat)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          lowFat = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'lowFat', lowFat);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Low Fat',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (pescatarian == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (pescatarian)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          pescatarian = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'pescatarian',
                                                            pescatarian);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Pescatarian',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (cleanEating == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (cleanEating)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          cleanEating = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'cleanEating',
                                                            cleanEating);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Clean Eating',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (peanutFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (peanutFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          peanutFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'peanutFree',
                                                            peanutFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Peanut Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (porkFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (porkFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          porkFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'porkFree',
                                                            porkFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Pork Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (redMeatFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (redMeatFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          redMeatFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'redMeatFree',
                                                            redMeatFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Red Meat Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (sesameFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (sesameFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          sesameFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'sesameFree',
                                                            sesameFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Sesame Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (shellfishFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (shellfishFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          shellfishFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'shellfishFree',
                                                            shellfishFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Shellfish Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (soyFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (soyFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          soyFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'soyFree', soyFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Soy Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (treenutFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (treenutFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          treenutFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'treenutFree',
                                                            treenutFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Treenut Free',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (heartHealthy == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (heartHealthy)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          heartHealthy = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            'heartHealthy',
                                                            heartHealthy);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Heart Healthy',
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (vegetarian == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (vegetarian)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          vegetarian = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "vegetarian",
                                                            vegetarian);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Vegetarian",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (vegan == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (vegan == true)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          vegan = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "vegan", vegan);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Vegan",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (ketogenic == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (ketogenic)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          ketogenic = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "ketogenic",
                                                            ketogenic);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Ketogenic",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (paleo == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (paleo)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          paleo = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "paleo", paleo);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Paleo",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (lowSalt == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (lowSalt)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          lowSalt = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "lowSalt", lowSalt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Low Salt",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (lowSugar == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (lowSugar)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          lowSugar = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "lowSugar",
                                                            lowSugar);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Low Sugar",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (dairyFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (dairyFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          dairyFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "dairyFree",
                                                            dairyFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Dairy Free",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                        if (glutenFree == true)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (glutenFree)
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Material(
                                                    color:
                                                        circleBack, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                              .blueGrey[
                                                          100], // inkwell color
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  circleFront)),
                                                      onTap: () {
                                                        setState(() {
                                                          glutenFree = false;
                                                          defaultSettingLength =
                                                              defaultSettingLength -
                                                                  1;
                                                        });
                                                        submitCondition(
                                                            "glutenFree",
                                                            glutenFree);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Gluten Free",
                                                  style: descriptionText,
                                                  textAlign: TextAlign.left,
                                                )
                                              ])),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 30),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "USER ADDED CONDITIONS",
                                        style: secondaryHeaderText,
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: _firestore
                                          .collection('findFoodQueryData')
                                          .where('sessionID',
                                              isEqualTo: sessionID)
                                          .limit(1)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final conditions =
                                              snapshot.data.documents;
                                          List<Widget> conditionWidgets = [];
                                          for (var session in conditions) {
                                            //Nutrient Declarations
                                            final calorieConditions =
                                                session.data['calorie'];
                                            final carbohydrateConditions =
                                                session.data['carbohydrates'];
                                            final ingredientConditions =
                                                session.data['ingredient'];
                                            final fatConditions =
                                                session.data['fat'];
                                            final proteinConditions =
                                                session.data['protein'];
                                            final calciumConditions =
                                                session.data['calcium'];
                                            final cholesterolConditions =
                                                session.data['cholesterol'];
                                            final monounsaturatedConditions =
                                                session.data['monounsaturated'];
                                            final polyunsaturatedConditions =
                                                session.data['polyunsaturated'];
                                            final saturatedConditions =
                                                session.data['saturated'];
                                            final transConditions =
                                                session.data['trans'];
                                            final ironConditions =
                                                session.data['iron'];
                                            final fiberConditions =
                                                session.data['fiber'];
                                            final folateConditions =
                                                session.data['folate'];
                                            final potassiumConditions =
                                                session.data['potassium'];
                                            final magnesiumConditions =
                                                session.data['magnesium'];
                                            final sodiumConditions =
                                                session.data['sodium'];
                                            final niacinb3Conditions =
                                                session.data['niacinb3'];
                                            final phosphorusConditions =
                                                session.data['phosphorus'];
                                            final riboflavinb2Conditions =
                                                session.data['riboflavinb2'];
                                            final sugarsConditions =
                                                session.data['sugars'];
                                            final thiaminb1Conditions =
                                                session.data['thiaminb1'];
                                            final vitamineConditions =
                                                session.data['vitamine'];
                                            final vitaminaConditions =
                                                session.data['vitamina'];
                                            final vitaminb12Conditions =
                                                session.data['vitaminb12'];
                                            final vitaminb6Conditions =
                                                session.data['vitaminb6'];
                                            final vitamincConditions =
                                                session.data['vitaminc'];
                                            final vitamindConditions =
                                                session.data['vitamind'];
                                            final vitaminkConditions =
                                                session.data['vitamink'];

                                            //Diet Declarations
                                            final glutenFreeConditions =
                                                session.data['glutenFree'];
                                            final ketogenicConditions =
                                                session.data['ketogenic'];
                                            final dairyFreeConditions =
                                                session.data['dairyFree'];
                                            final lowSaltConditions =
                                                session.data['lowSalt'];
                                            final lowSugarConditions =
                                                session.data['lowSugar'];
                                            final paleoConditions =
                                                session.data['paleo'];
                                            final veganConditions =
                                                session.data['vegan'];
                                            final vegetarianConditions =
                                                session.data['vegetarian'];
                                            final eggFreeConditions =
                                                session.data['eggFree'];
                                            final fishFreeConditions =
                                                session.data['fishFree'];
                                            final lowFODMAPConditions =
                                                session.data['lowFODMAP'];
                                            final balancedConditions =
                                                session.data['balanced'];
                                            final cleanEatingConditions =
                                                session.data['cleanEating'];
                                            final highFiberConditions =
                                                session.data['highFiber'];
                                            final highProteinConditions =
                                                session.data['highProtein'];
                                            final diabeticFriendlyConditions =
                                                session
                                                    .data['diabeticFriendly'];
                                            final lowCarbConditions =
                                                session.data['lowCarb'];
                                            final lowFatConditions =
                                                session.data['lowFat'];
                                            final pescatarianConditions =
                                                session.data['pescatarian'];
                                            final peanutFreeConditions =
                                                session.data['peanutFree'];
                                            final porkFreeConditions =
                                                session.data['porkFree'];
                                            final redMeatFreeConditions =
                                                session.data['redMeatFree'];
                                            final sesameFreeConditions =
                                                session.data['sesameFree'];
                                            final shellfishFreeConditions =
                                                session.data['shellfishFree'];
                                            final soyFreeConditions =
                                                session.data['soyFree'];
                                            final treenutFreeConditions =
                                                session.data['treenutFree'];
                                            final heartHealthyConditions =
                                                session.data['heartHealthy'];

                                            //Meal Type Declarations
                                            final breakfastAndBrunchConditions =
                                                session
                                                    .data['breakfastAndBrunch'];
                                            final dessertsConditions =
                                                session.data['desserts'];
                                            final dinnersConditions =
                                                session.data['dinners'];
                                            final lunchConditions =
                                                session.data['lunch'];
                                            final appetizersSnacksConditions =
                                                session
                                                    .data['appetizersSnacks'];
                                            final entertainingPartiesConditions =
                                                session.data[
                                                    'entertainingParties'];

                                            //Dish Type Declarations
                                            final breadsConditions =
                                                session.data['breads'];
                                            final cakesConditions =
                                                session.data['cakes'];
                                            final candyFudgeConditions =
                                                session.data['candyFudge'];
                                            final casserolesConditions =
                                                session.data['casseroles'];
                                            final cocktailsConditions =
                                                session.data['cocktails'];
                                            final cookiesConditions =
                                                session.data['cookies'];
                                            final macCheeseConditions =
                                                session.data['macCheese'];
                                            final mainDishesConditions =
                                                session.data['mainDishes'];
                                            final pastaSaladsConditions =
                                                session.data['pastaSalads'];
                                            final pastaConditions =
                                                session.data['pasta'];
                                            final piesConditions =
                                                session.data['pies'];
                                            final pizzasConditions =
                                                session.data['pizzas'];
                                            final sandwichesConditions =
                                                session.data['sandwiches'];
                                            final saucesCondimentsConditions =
                                                session
                                                    .data['saucesCondiments'];
                                            final smoothiesConditions =
                                                session.data['smoothies'];
                                            final soupsConditions =
                                                session.data['soups'];
                                            final bbqConditions =
                                                session.data['bbq'];
                                            final kidsConditions =
                                                session.data['kids'];
                                            final twoConditions =
                                                session.data['two'];
                                            final budgetCookingConditions =
                                                session.data['budgetCooking'];
                                            final pressureCookerConditions =
                                                session.data['pressureCooker'];
                                            final quickEasyConditions =
                                                session.data['quickEasy'];
                                            final slowCookerConditions =
                                                session.data['slowCooker'];

                                            //Cuisine Type Declarations
                                            final africanConditions =
                                                session.data['african'];
                                            final americanConditions =
                                                session.data['american'];
                                            final argentinianConditions =
                                                session.data['argentinian'];
                                            final australianConditions =
                                                session.data['australian'];
                                            final austrianConditions =
                                                session.data['austrian'];
                                            final bangladeshiConditions =
                                                session.data['bangladeshi'];
                                            final belgianConditions =
                                                session.data['belgian'];
                                            final brazilianConditions =
                                                session.data['brazilian'];
                                            final canadianConditions =
                                                session.data['canadian'];
                                            final chileanConditions =
                                                session.data['chilean'];
                                            final chineseConditions =
                                                session.data['chinese'];
                                            final colombianConditions =
                                                session.data['colombian'];
                                            final cubanConditions =
                                                session.data['cuban'];
                                            final dutchConditions =
                                                session.data['dutch'];
                                            final easternEuropeanConditions =
                                                session.data['easternEuropean'];
                                            final filipinoConditions =
                                                session.data['filipino'];
                                            final frenchConditions =
                                                session.data['french'];
                                            final germanConditions =
                                                session.data['german'];
                                            final greekConditions =
                                                session.data['greek'];
                                            final indianConditions =
                                                session.data['indian'];
                                            final indonesianConditions =
                                                session.data['indonesian'];
                                            final israeliConditions =
                                                session.data['israeli'];
                                            final italianConditions =
                                                session.data['italian'];
                                            final jamaicanConditions =
                                                session.data['jamaican'];
                                            final japaneseConditions =
                                                session.data['japanese'];
                                            final koreanConditions =
                                                session.data['korean'];
                                            final lebaneseConditions =
                                                session.data['lebanese'];
                                            final malaysianConditions =
                                                session.data['malaysian'];
                                            final mediterraneanConditions =
                                                session.data['mediterranean'];
                                            final mexicanConditions =
                                                session.data['mexican'];
                                            final pakistaniConditions =
                                                session.data['pakistani'];
                                            final persianConditions =
                                                session.data['persian'];
                                            final peruvianConditions =
                                                session.data['peruvian'];
                                            final portugueseConditions =
                                                session.data['portuguese'];
                                            final puertoRicanConditions =
                                                session.data['puertoRican'];
                                            final scandinavianConditions =
                                                session.data['scandinavian'];
                                            final southernConditions =
                                                session.data['southern'];
                                            final spanishConditions =
                                                session.data['spanish'];
                                            final swissConditions =
                                                session.data['swiss'];
                                            final thaiConditions =
                                                session.data['thai'];
                                            final turkishConditions =
                                                session.data['turkish'];
                                            final ukIrishConditions =
                                                session.data['ukIrish'];
                                            final vietnameseConditions =
                                                session.data['vietnamese'];

                                            _conditions = {
                                              //Nutritional
                                              "calorieConditions": ['Calories',calorieConditions],
                                              "carbohydrateConditions": ['Carbohydrates',carbohydrateConditions],
                                              "ingredientConditions": ['Ingredients',ingredientConditions],
                                              "fatConditions": ['Fat',fatConditions],
                                              "proteinConditions": ['Protein',proteinConditions],
                                              'calciumConditions': ['Calcium',calciumConditions],
                                              'cholesterolConditions': ['Cholesterol',cholesterolConditions],
                                              'monounsaturatedConditions': ['MonounsaturatedFat',monounsaturatedConditions],
                                              'polyunsaturatedConditions': ['PolyunsaturatedFat',polyunsaturatedConditions],
                                              'saturatedConditions': ['SaturatedFat',saturatedConditions],
                                              'transConditions': ['TransFat',transConditions],
                                              'ironConditions': ['Iron',ironConditions],
                                              'fiberConditions': ['Fiber',fiberConditions],
                                              'folateConditions': ['Folate',folateConditions],
                                              'potassiumConditions': ['Potassium',potassiumConditions],
                                              'magnesiumConditions': ['Magnesium',magnesiumConditions],
                                              'sodiumConditions': ['Sodium',sodiumConditions],
                                              'niacinb3Conditions': ['VitaminB3',niacinb3Conditions],
                                              'phosphorusConditions': ['Phosphorus',phosphorusConditions],
                                              'riboflavinb2Conditions': ['VitaminB2',riboflavinb2Conditions],
                                              'sugarsConditions': ['Sugar',sugarsConditions],
                                              'thiaminb1Conditions': ['VitaminB1',thiaminb1Conditions],
                                              'vitamineConditions': ['VitaminE',vitamineConditions],
                                              'vitaminaConditions': ['VitaminA',vitaminaConditions],
                                              'vitaminb12Conditions': ['VitaminB12',vitaminb12Conditions],
                                              'vitaminb6Conditions': ['VitaminB6',vitaminb6Conditions],
                                              'vitamincConditions': ['VitaminC',vitamincConditions],
                                              'vitamindConditions': ['VitaminD',vitamindConditions],
                                              'vitaminkConditions': ['VitaminK',vitaminkConditions],
                                              //Dietary
                                              'diabeticFriendlyConditions':['Diabetic',diabeticFriendlyConditions],
                                              'heartHealthyConditions':['Heart-Healthy Recipes',heartHealthyConditions],
                                              'highFiberConditions':['High Fiber Recipes',highFiberConditions],
                                              'highProteinConditions':['High Protein',highProteinConditions],
                                              'lowCarbConditions':['Low Carb Recipes',lowCarbConditions],
                                              'lowFatConditions':['Low Fat',lowFatConditions],
                                              'lowFODMAPConditions':['Low FODMAP',lowFODMAPConditions],
                                              'glutenFreeConditions': ['Gluten Free',glutenFreeConditions],
                                              'ketogenicConditions': ['Ketogenic',ketogenicConditions],
                                              'dairyFreeConditions': ['Dairy Free Recipes',dairyFreeConditions],
                                              'lowSaltConditions': ['Low Salt',lowSaltConditions],
                                              'lowSugarConditions': ['Low Sugar',lowSugarConditions],
                                              'paleoConditions': ['Paleo',paleoConditions],
                                              'veganConditions': ['Vegan',veganConditions],
                                              'vegetarianConditions': ['Vegetarian',vegetarianConditions],
                                              'eggFreeConditions': ['Egg Free',eggFreeConditions],
                                              'fishFreeConditions': ['Fish Free',fishFreeConditions],
                                              'balancedConditions': ['Healthy',balancedConditions],
                                              'cleanEatingConditions': ['Clean-Eating',cleanEatingConditions],
                                              'peanutFreeConditions':['Peanut Free',peanutFreeConditions],
                                              'porkFreeConditions':['Pork Free',porkFreeConditions],
                                              'redMeatFreeConditions':['Red Meat Free',redMeatFreeConditions],
                                              'sesameFreeConditions':['Sesame Free',sesameFreeConditions],
                                              'shellfishFreeConditions':['Shellfish Free',shellfishFreeConditions],
                                              'soyFreeConditions':['Soy Free',soyFreeConditions],
                                              'treenutFreeConditions':['Tree Nut Free',treenutFreeConditions],
                                              //Dishes
                                              'breadsDishCondition':['Bread Recipes',breadsConditions],
                                              'cakesDishCondition':['Cake Recipes',cakesConditions],
                                              'candyDishCondition':['Candy and Fudge',candyFudgeConditions],
                                              'casseroleDishCondition':['Casserole Recipes',casserolesConditions],
                                              'cocktailDishCondition':['Cocktail Recipes',cocktailsConditions],
                                              'cookieDishCondition':['Cookie Recipes',cookiesConditions],
                                              'macandcheeseDishCondition':['Mac and Cheese Recipes',macCheeseConditions],
                                              'mainDishesCondition':['Main Dishes',mainDishesConditions],
                                              'pastaSaladDishCondition':['Pasta Salad Recipes',pastaSaladsConditions],
                                              'pastaDishCondition': ['Pasta Recipes',pastaConditions],
                                              'pieDishCondition':['Pie Recipes',piesConditions],
                                              'pizzaDishCondition':['Pizza',pizzasConditions],
                                              'sandwichDishCondition':['Sandwiches',sandwichesConditions],
                                              'saucesDishCondition':['Sauces and Condiments',saucesCondimentsConditions],
                                              'smoothiesDishCondition':['Smoothie Recipes',smoothiesConditions],
                                              'soupsDishCondition':['Soups',soupsConditions],
                                              'bbqDishCondition':['BBQ & Grilling',bbqConditions],
                                              'kidsDishCondition':['Cooking For Kids',kidsConditions],
                                              'forTwoDishCondition':['Cooking for Two',twoConditions],
                                              'budgetDishCondition':['Budget Cooking',budgetCookingConditions],
                                              'pressureCookerDishCondition':['Pressure Cooker',pressureCookerConditions],
                                              'quickEasyDishCondition':['Quick & Easy',quickEasyConditions],
                                              'slowCookerDishCondition' : ['Slow Cooker',slowCookerConditions],
                                              //Meal type
                                              'breakfastAndBrunchConditions' : ['Breakfast and Brunch',breakfastAndBrunchConditions],
                                              'dinnerConditions' : ['Dinners',dinnersConditions],
                                              'dessertsConditions': ['Desserts',dessertsConditions],
                                              'lunchConditions': ['Lunch',lunchConditions],
                                              'entertainingPartiesConditions': ['Entertaining and Dinner Parties',entertainingPartiesConditions],
                                              //Cuisines
                                              'africanConditions': ['African',africanConditions],
                                              'americanConditions': ['American',americanConditions],
                                              'argentinianConditions': ['Argentenian',argentinianConditions],
                                              'australianConditions': ['Australian',australianConditions],
                                              'austrianConditions': ['Austrian',austrianConditions],
                                              'bangladeshiConditions': ['Bangladeshi',bangladeshiConditions],
                                              'belgianConditions': ['Belgian',belgianConditions],
                                              'brazilianConditions': ['Brazilian',brazilianConditions],
                                              'canadianConditions': ['Canadian',canadianConditions],
                                              'chileanConditions': ['Chilean',chileanConditions],
                                              'chineseConditions': ['Chinese',chineseConditions],
                                              'colombianConditions': ['Colombian',colombianConditions],
                                              'cubanConditions': ['Cuban',cubanConditions],
                                              'dutchConditions': ['Dutch',dutchConditions],
                                              'easternEuropeanConditions': ['Eastern European',easternEuropeanConditions],
                                              'filipinoConditions': ['Filipino',filipinoConditions],
                                              'frenchConditions': ['French',frenchConditions],
                                              'germanConditions': ['German',germanConditions],
                                              'greekConditions': ['Greek',greekConditions],
                                              'indianConditions': ['Indian',indianConditions],
                                              'indonesianConditions': ['Indonesian',indonesianConditions],
                                              'israeliConditions': ['Israeli',israeliConditions],
                                              'italianConditions': ['Italian',italianConditions],
                                              'jamaicanConditions': ['Jamaican',jamaicanConditions],
                                              'japaneseConditions': ['Japanese',japaneseConditions],
                                              'koreanConditions': ['Korean',koreanConditions],
                                              'lebaneseConditions': ['Lebanese',lebaneseConditions],
                                              'malaysianConditions': ['Malaysian',malaysianConditions],
                                              'mediterraneanConditions': ['Mediterranean',mediterraneanConditions],
                                              'mexicanConditions': ['Mexican',mexicanConditions],
                                              'pakistaniConditions': ['Pakistani',pakistaniConditions],
                                              'persianConditions': ['Persian',persianConditions],
                                              'peruvianConditions': ['Peruvian',peruvianConditions],
                                              'portugueseConditions': ['Puortuguese',portugueseConditions],
                                              'puertoRicanConditions': ['Puerto Rican',puertoRicanConditions],
                                              'scandinavianConditions': ['Scandinavian',scandinavianConditions],
                                              'southernConditions': ['Southern',southernConditions],
                                              'spanishConditions': ['Spanish',spanishConditions],
                                              'swissConditions': ['Swiss',swissConditions],
                                              'thaiConditions': ['Thai',thaiConditions],
                                              'turkishConditions': ['Turkish',turkishConditions],
                                              'ukIrishConditions': ['UK & Irish',ukIrishConditions],
                                              'vietnameseConditions': ['Vietnamese',vietnameseConditions],
                                              };

                                            //If conditions aren't null, and not already existing, add to widget list.
                                            if (calorieConditions != null) {
                                              final calorieConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          "calorie");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Calories: " +
                                                                  calorieConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(calorieConditionWidget);
                                            }

                                            if (calciumConditions != null) {
                                              final calciumConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'calcium');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Calcium (mg): ' +
                                                                  calciumConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(calciumConditionsWidget);
                                            }

                                            if (cholesterolConditions != null) {
                                              final cholesterolConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'cholesterol');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cholesterol (mg): ' +
                                                                  cholesterolConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  cholesterolConditionsWidget);
                                            }

                                            if (monounsaturatedConditions !=
                                                null) {
                                              final monounsaturatedConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'monounsaturated');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Monounsaturated Fats (g): ' +
                                                                  monounsaturatedConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  monounsaturatedConditionsWidget);
                                            }

                                            if (polyunsaturatedConditions !=
                                                null) {
                                              final polyunsaturatedConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'polyunsaturated');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Polyunsaturated Fats (g): ' +
                                                                  polyunsaturatedConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  polyunsaturatedConditionsWidget);
                                            }

                                            if (saturatedConditions != null) {
                                              final saturatedConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'saturated');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Saturated Fats (g): ' +
                                                                  saturatedConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  saturatedConditionsWidget);
                                            }

                                            if (transConditions != null) {
                                              final transConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'trans');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Trans Fats (g): ' +
                                                                  transConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(transConditionsWidget);
                                            }

                                            if (ironConditions != null) {
                                              final ironConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'iron');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Iron (mg): ' +
                                                                  ironConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(ironConditionsWidget);
                                            }

                                            if (fiberConditions != null) {
                                              final fiberConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'fiber');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Fiber (g): ' +
                                                                  fiberConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(fiberConditionsWidget);
                                            }

                                            if (folateConditions != null) {
                                              final folateConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'folate');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Folate (μg): ' +
                                                                  folateConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(folateConditionsWidget);
                                            }

                                            if (potassiumConditions != null) {
                                              final potassiumConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'potassium');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Potassium (mg): ' +
                                                                  potassiumConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  potassiumConditionsWidget);
                                            }

                                            if (magnesiumConditions != null) {
                                              final magnesiumConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'magnesium');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Magnesium (mg): ' +
                                                                  magnesiumConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  magnesiumConditionsWidget);
                                            }

                                            if (sodiumConditions != null) {
                                              final sodiumConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'sodium');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Sodium (mg): ' +
                                                                  sodiumConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(sodiumConditionsWidget);
                                            }

                                            if (niacinb3Conditions != null) {
                                              final niacinb3ConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'niacinb3');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Niacin (B3) (mg): ' +
                                                                  niacinb3Conditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  niacinb3ConditionsWidget);
                                            }

                                            if (phosphorusConditions != null) {
                                              final phosphorusConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'phosphorus');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Phosphorus (mg): ' +
                                                                  phosphorusConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  phosphorusConditionsWidget);
                                            }

                                            if (riboflavinb2Conditions !=
                                                null) {
                                              final riboflavinb2ConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'riboflavinb2');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Riboflavin (B2) (mg): ' +
                                                                  riboflavinb2Conditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  riboflavinb2ConditionsWidget);
                                            }

                                            if (sugarsConditions != null) {
                                              final sugarsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'sugars');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Sugars (g): ' +
                                                                  sugarsConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(sugarsConditionsWidget);
                                            }

                                            if (thiaminb1Conditions != null) {
                                              final thiaminb1ConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'thiaminb1');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Thiamin (B1) (mg): ' +
                                                                  thiaminb1Conditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  thiaminb1ConditionsWidget);
                                            }

                                            if (vitamineConditions != null) {
                                              final vitamineConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitamine');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin E (mg): ' +
                                                                  vitamineConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitamineConditionsWidget);
                                            }

                                            if (vitaminaConditions != null) {
                                              final vitaminaConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitamina');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin A (μg): ' +
                                                                  vitaminaConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitaminaConditionsWidget);
                                            }

                                            if (vitaminb12Conditions != null) {
                                              final vitaminb12ConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitaminb12');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin B12 (μg): ' +
                                                                  vitaminb12Conditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitaminb12ConditionsWidget);
                                            }

                                            if (vitaminb6Conditions != null) {
                                              final vitaminb6ConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitaminb6');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin B6 (mg): ' +
                                                                  vitaminb6Conditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitaminb6ConditionsWidget);
                                            }

                                            if (vitamincConditions != null) {
                                              final vitamincConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitaminc');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin C (mg): ' +
                                                                  vitamincConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitamincConditionsWidget);
                                            }

                                            if (vitamindConditions != null) {
                                              final vitamindConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitamind');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin D (μg): ' +
                                                                  vitamindConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitamindConditionsWidget);
                                            }

                                            if (vitaminkConditions != null) {
                                              final vitaminkConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
//Remove condition from database
                                                                      removeCondition(
                                                                          'vitamink');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Vitamin K (μg): ' +
                                                                  vitaminkConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vitaminkConditionsWidget);
                                            }

                                            if (breakfastAndBrunchConditions ==
                                                true) {
                                              final breakfastAndBrunchConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'breakfastAndBrunch');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Meal Type: ' +
                                                                  'Breakfast & Brunch',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  breakfastAndBrunchConditionsWidget);
                                            }
                                            if (dessertsConditions == true) {
                                              final dessertsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'desserts');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Meal Type: ' +
                                                                  'Desserts',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  dessertsConditionsWidget);
                                            }
                                            if (dinnersConditions == true) {
                                              final dinnersConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'dinners');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Meal Type: ' +
                                                                  'Dinners',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(dinnersConditionsWidget);
                                            }
                                            if (lunchConditions == true) {
                                              final lunchConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'lunch');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Meal Type: ' +
                                                                  'Lunch',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(lunchConditionsWidget);
                                            }
                                            if (appetizersSnacksConditions ==
                                                true) {
                                              final appetizersSnacksConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'appetizersSnacks');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Meal Type: ' +
                                                                  'Appetizers & Snacks',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  appetizersSnacksConditionsWidget);
                                            }
                                            if (entertainingPartiesConditions ==
                                                true) {
                                              final entertainingPartiesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'entertainingParties');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Meal Type: ' +
                                                                  'Entertaining & Dinner Parties',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  entertainingPartiesConditionsWidget);
                                            }

                                            if (breadsConditions == true) {
                                              final breadsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'breads');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Breads',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(breadsConditionsWidget);
                                            }
                                            if (cakesConditions == true) {
                                              final cakesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'cakes');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Cakes',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(cakesConditionsWidget);
                                            }
                                            if (candyFudgeConditions == true) {
                                              final candyFudgeConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'candyFudge');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Candy & Fudge',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  candyFudgeConditionsWidget);
                                            }
                                            if (casserolesConditions == true) {
                                              final casserolesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'casseroles');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Casseroles',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  casserolesConditionsWidget);
                                            }
                                            if (cocktailsConditions == true) {
                                              final cocktailsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'cocktails');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Cocktails',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  cocktailsConditionsWidget);
                                            }
                                            if (cookiesConditions == true) {
                                              final cookiesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'cookies');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Cookies',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(cookiesConditionsWidget);
                                            }
                                            if (macCheeseConditions == true) {
                                              final macCheeseConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'macCheese');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Mac & Cheese',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  macCheeseConditionsWidget);
                                            }
                                            if (mainDishesConditions == true) {
                                              final mainDishesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'mainDishes');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Main Dishes',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  mainDishesConditionsWidget);
                                            }
                                            if (pastaSaladsConditions == true) {
                                              final pastaSaladsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'pastaSalads');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Pasta Salads',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  pastaSaladsConditionsWidget);
                                            }
                                            if (pastaConditions == true) {
                                              final pastaConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'pasta');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Pasta',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(pastaConditionsWidget);
                                            }
                                            if (piesConditions == true) {
                                              final piesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'pies');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Pies',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(piesConditionsWidget);
                                            }
                                            if (pizzasConditions == true) {
                                              final pizzasConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'pizzas');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Pizzas',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(pizzasConditionsWidget);
                                            }
                                            if (sandwichesConditions == true) {
                                              final sandwichesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'sandwiches');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Sandwiches',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  sandwichesConditionsWidget);
                                            }
                                            if (saucesCondimentsConditions ==
                                                true) {
                                              final saucesCondimentsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'saucesCondiments');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Sauces & Condiments',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  saucesCondimentsConditionsWidget);
                                            }
                                            if (smoothiesConditions == true) {
                                              final smoothiesConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'smoothies');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Smoothies',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  smoothiesConditionsWidget);
                                            }
                                            if (soupsConditions == true) {
                                              final soupsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'soups');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Soups, Stews, & Chilis',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(soupsConditionsWidget);
                                            }
                                            if (bbqConditions == true) {
                                              final bbqConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'bbq');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'BBQ & Grilling',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(bbqConditionsWidget);
                                            }
                                            if (kidsConditions == true) {
                                              final kidsConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'kids');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'For Kids',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(kidsConditionsWidget);
                                            }
                                            if (twoConditions == true) {
                                              final twoConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'two');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'For Two',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(twoConditionsWidget);
                                            }
                                            if (budgetCookingConditions ==
                                                true) {
                                              final budgetCookingConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'budgetCooking');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Budget Cooking',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  budgetCookingConditionsWidget);
                                            }
                                            if (pressureCookerConditions ==
                                                true) {
                                              final pressureCookerConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'pressureCooker');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Pressure Cooker',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  pressureCookerConditionsWidget);
                                            }
                                            if (quickEasyConditions == true) {
                                              final quickEasyConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'quickEasy');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Quick & Easy',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  quickEasyConditionsWidget);
                                            }
                                            if (slowCookerConditions == true) {
                                              final slowCookerConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'slowCooker');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Dish Type: ' +
                                                                  'Slow Cooker',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  slowCookerConditionsWidget);
                                            }

                                            if (africanConditions == true) {
                                              final africanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'african');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'African',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(africanConditionsWidget);
                                            }
                                            if (americanConditions == true) {
                                              final americanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'american');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'American',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  americanConditionsWidget);
                                            }
                                            if (argentinianConditions ==
                                                true) {
                                              final argentinianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'aregentinian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Argentinian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  argentinianConditionsWidget);
                                            }
                                            if (australianConditions == true) {
                                              final australianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'australian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Australian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  australianConditionsWidget);
                                            }
                                            if (austrianConditions == true) {
                                              final austrianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'austrian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Austrian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  austrianConditionsWidget);
                                            }
                                            if (bangladeshiConditions == true) {
                                              final bangladeshiConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'bangladeshi');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Bangladeshi',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  bangladeshiConditionsWidget);
                                            }
                                            if (belgianConditions == true) {
                                              final belgianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'belgian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Belgian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(belgianConditionsWidget);
                                            }
                                            if (brazilianConditions == true) {
                                              final brazilianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'brazilian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Brazilian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  brazilianConditionsWidget);
                                            }
                                            if (canadianConditions == true) {
                                              final canadianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'canadian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Canadian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  canadianConditionsWidget);
                                            }
                                            if (chileanConditions == true) {
                                              final chileanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'chilean');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Chilean',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(chileanConditionsWidget);
                                            }
                                            if (chineseConditions == true) {
                                              final chineseConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'chinese');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Chinese',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(chineseConditionsWidget);
                                            }
                                            if (colombianConditions == true) {
                                              final colombianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'colombian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Colombian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  colombianConditionsWidget);
                                            }
                                            if (cubanConditions == true) {
                                              final cubanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'cuban');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Cuban',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(cubanConditionsWidget);
                                            }
                                            if (dutchConditions == true) {
                                              final dutchConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'dutch');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Dutch',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(dutchConditionsWidget);
                                            }
                                            if (easternEuropeanConditions ==
                                                true) {
                                              final easternEuropeanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'easternEuropean');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Eastern European',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  easternEuropeanConditionsWidget);
                                            }
                                            if (filipinoConditions == true) {
                                              final filipinoConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'filipino');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Filipino',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  filipinoConditionsWidget);
                                            }
                                            if (frenchConditions == true) {
                                              final frenchConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'french');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'French',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(frenchConditionsWidget);
                                            }
                                            if (germanConditions == true) {
                                              final germanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'german');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'German',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(germanConditionsWidget);
                                            }
                                            if (greekConditions == true) {
                                              final greekConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'greek');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Greek',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(greekConditionsWidget);
                                            }
                                            if (indianConditions == true) {
                                              final indianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'indian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Indian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(indianConditionsWidget);
                                            }
                                            if (indonesianConditions == true) {
                                              final indonesianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'indonesian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Indonesian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  indonesianConditionsWidget);
                                            }
                                            if (israeliConditions == true) {
                                              final israeliConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'israeli');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Israeli',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(israeliConditionsWidget);
                                            }
                                            if (italianConditions == true) {
                                              final italianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'italian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Italian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(italianConditionsWidget);
                                            }
                                            if (jamaicanConditions == true) {
                                              final jamaicanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'jamaican');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Jamaican',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  jamaicanConditionsWidget);
                                            }
                                            if (japaneseConditions == true) {
                                              final japaneseConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'japanese');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Japanese',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  japaneseConditionsWidget);
                                            }
                                            if (koreanConditions == true) {
                                              final koreanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'korean');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Korean',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(koreanConditionsWidget);
                                            }
                                            if (lebaneseConditions == true) {
                                              final lebaneseConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'lebanese');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Lebanese',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  lebaneseConditionsWidget);
                                            }
                                            if (malaysianConditions == true) {
                                              final malaysianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'malaysian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Malaysian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  malaysianConditionsWidget);
                                            }
                                            if (mediterraneanConditions ==
                                                true) {
                                              final mediterraneanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'mediterranean');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Mediterranean',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  mediterraneanConditionsWidget);
                                            }
                                            if (mexicanConditions == true) {
                                              final mexicanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'mexican');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Mexican',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(mexicanConditionsWidget);
                                            }
                                            if (pakistaniConditions == true) {
                                              final pakistaniConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'pakistani');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Pakistani',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  pakistaniConditionsWidget);
                                            }
                                            if (persianConditions == true) {
                                              final persianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'persian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Persian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(persianConditionsWidget);
                                            }
                                            if (peruvianConditions == true) {
                                              final peruvianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'peruvian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Peruvian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  peruvianConditionsWidget);
                                            }
                                            if (portugueseConditions == true) {
                                              final portugueseConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'portuguese');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Portuguese',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  portugueseConditionsWidget);
                                            }
                                            if (puertoRicanConditions == true) {
                                              final puertoRicanConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'puertoRican');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Puerto Rican',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  puertoRicanConditionsWidget);
                                            }
                                            if (scandinavianConditions ==
                                                true) {
                                              final scandinavianConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'scandinavian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Scandinavian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  scandinavianConditionsWidget);
                                            }
                                            if (southernConditions == true) {
                                              final southernConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'southern');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Southern',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  southernConditionsWidget);
                                            }
                                            if (spanishConditions == true) {
                                              final spanishConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'spanish');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Spanish',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(spanishConditionsWidget);
                                            }
                                            if (swissConditions == true) {
                                              final swissConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'swiss');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Swiss',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(swissConditionsWidget);
                                            }
                                            if (thaiConditions == true) {
                                              final thaiConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'thai');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Thai',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(thaiConditionsWidget);
                                            }
                                            if (turkishConditions == true) {
                                              final turkishConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'turkish');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Turkish',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(turkishConditionsWidget);
                                            }
                                            if (ukIrishConditions == true) {
                                              final ukIrishConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'ukIrish');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'UK & Irish',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(ukIrishConditionsWidget);
                                            }
                                            if (vietnameseConditions == true) {
                                              final vietnameseConditionsWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors.blueGrey[
                                                                          100],
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          'vietnamese');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Cuisine Type: ' +
                                                                  'Vietnamese',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vietnameseConditionsWidget);
                                            }

                                            if (ingredientConditions != null) {
                                              final ingredientConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "ingredient");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Ingredients: " +
                                                                  ingredientConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  ingredientConditionWidget);
                                            }

                                            if (carbohydrateConditions !=
                                                null) {
                                              final carbohydrateConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "carbohydrates");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Carbohydrates (g): " +
                                                                  carbohydrateConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  carbohydrateConditionWidget);
                                            }

                                            if (fatConditions != null) {
                                              final fatConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "fat");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Fat (g): " +
                                                                  fatConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(fatConditionWidget);
                                            }

                                            if (glutenFreeConditions &&
                                                glutenFree != true) {
                                              final glutenFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "glutenFree");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Gluten Free.",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  glutenFreeConditionWidget);
                                            }

                                            if (ketogenicConditions &&
                                                ketogenic != true) {
                                              final ketogenicFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "ketogenic");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Ketogenic",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  ketogenicFreeConditionWidget);
                                            }

                                            if (dairyFreeConditions &&
                                                dairyFree != true) {
                                              final dairyFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "dairyFree");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Dairy Free",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  dairyFreeConditionWidget);
                                            }

                                            if (lowSaltConditions &&
                                                lowSalt != true) {
                                              final lowSaltConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "lowSalt");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Low Salt",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(lowSaltConditionWidget);
                                            }

                                            if (lowSugarConditions &&
                                                lowSugar != true) {
                                              final lowSugarConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "lowSugar");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Low Sugar",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(lowSugarConditionWidget);
                                            }

                                            if (paleoConditions &&
                                                paleo != true) {
                                              final paleoConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "paleo");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Paleo",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(paleoConditionWidget);
                                            }

                                            if (proteinConditions != null) {
                                              final proteinConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "protein");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Protein (g): " +
                                                                  proteinConditions,
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(proteinConditionWidget);
                                            }

                                            if (veganConditions &&
                                                vegan != true) {
                                              final veganConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "vegan");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Vegan",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(veganConditionWidget);
                                            }

                                            if (vegetarianConditions &&
                                                vegetarian != true) {
                                              final vegetarianConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      removeCondition(
                                                                          "vegetarian");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Vegetarian",
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  vegetarianConditionWidget);
                                            }

                                            if (eggFreeConditions == true &&
                                                eggFree != true) {
                                              final eggFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'eggFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Egg Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(eggFreeConditionWidget);
                                            }

                                            if (fishFreeConditions == true &&
                                                fishFree != true) {
                                              final fishFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'fishFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Fish Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(fishFreeConditionWidget);
                                            }

                                            if (lowFODMAPConditions == true &&
                                                lowFODMAP != true) {
                                              final lowFODMAPConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'lowFODMAP');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Low FODMAP',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  lowFODMAPConditionWidget);
                                            }

                                            if (balancedConditions == true &&
                                                balanced != true) {
                                              final balancedConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'balanced');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Balanced',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(balancedConditionWidget);
                                            }

                                            if (highFiberConditions == true &&
                                                highFiber != true) {
                                              final highFiberConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'highFiber');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'High Fiber',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  highFiberConditionWidget);
                                            }

                                            if (highProteinConditions == true &&
                                                highProtein != true) {
                                              final highProteinConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'highProtein');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'High Protein',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  highProteinConditionWidget);
                                            }

                                            if (diabeticFriendlyConditions ==
                                                    true &&
                                                diabeticFriendly != true) {
                                              final diabeticFriendlyConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'diabeticFriendly');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Kidney Friendly',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  diabeticFriendlyConditionWidget);
                                            }

                                            if (lowCarbConditions == true &&
                                                lowCarb != true) {
                                              final lowCarbConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'lowCarb');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Low Carb',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(lowCarbConditionWidget);
                                            }

                                            if (lowFatConditions == true &&
                                                lowFat != true) {
                                              final lowFatConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'lowFat');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Low Fat',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(lowFatConditionWidget);
                                            }

                                            if (pescatarianConditions == true &&
                                                pescatarian != true) {
                                              final pescatarianConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'pescatarian');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Pescatarian',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  pescatarianConditionWidget);
                                            }

                                            if (cleanEatingConditions == true &&
                                                cleanEating != true) {
                                              final cleanEatingConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'cleanEating');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Clean Eating',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  cleanEatingConditionWidget);
                                            }

                                            if (peanutFreeConditions == true &&
                                                peanutFree != true) {
                                              final peanutFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'peanutFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Peanut Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  peanutFreeConditionWidget);
                                            }

                                            if (porkFreeConditions == true &&
                                                porkFree != true) {
                                              final porkFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'porkFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Pork Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(porkFreeConditionWidget);
                                            }

                                            if (redMeatFreeConditions == true &&
                                                redMeatFree != true) {
                                              final redMeatFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'redMeatFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Red Meat Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  redMeatFreeConditionWidget);
                                            }

                                            if (sesameFreeConditions == true &&
                                                sesameFree != true) {
                                              final sesameFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'sesameFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Sesame Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  sesameFreeConditionWidget);
                                            }

                                            if (shellfishFreeConditions ==
                                                    true &&
                                                shellfishFree != true) {
                                              final shellfishFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'shellfishFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Shellfish Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  shellfishFreeConditionWidget);
                                            }

                                            if (soyFreeConditions == true &&
                                                soyFree != true) {
                                              final soyFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'soyFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Soy Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets
                                                  .add(soyFreeConditionWidget);
                                            }

                                            if (treenutFreeConditions == true &&
                                                treenutFree != true) {
                                              final treenutFreeConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'treenutFree');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Tree Nut Free',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  treenutFreeConditionWidget);
                                            }

                                            if (heartHealthyConditions ==
                                                    true &&
                                                heartHealthy != true) {
                                              final heartHealthyConditionWidget =
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(children: [
                                                            ClipOval(
                                                              child: Material(
                                                                color:
                                                                    circleBack, // button color
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                          .blueGrey[
                                                                      100], // inkwell color
                                                                  child: SizedBox(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              circleFront)),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      //Remove condition from database
                                                                      removeCondition(
                                                                          'heartHealthy');
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Heart Healthy',
                                                              style:
                                                                  descriptionText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ])));
                                              conditionWidgets.add(
                                                  heartHealthyConditionWidget);
                                            }
                                          }
                                          // ignore: missing_return
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                                children: conditionWidgets),
                                          );
                                        }
                                        else
                                          return Container();
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(children: [
                                        ClipOval(
                                          child: Material(
                                            color: Color.fromRGBO(
                                                195, 200, 226, 1), //
                                            // button color
                                            child: InkWell(
                                              splashColor: Colors.blueGrey[
                                                  100], // inkwell color
                                              child: SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Icon(Icons.add,
                                                      color: Color.fromRGBO(
                                                          75, 77, 94, 1))),
                                              onTap: () {
                                                addCondition(context);
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Press to add condition.",
                                          style: descriptionText,
                                          textAlign: TextAlign.left,
                                        )
                                      ])),
                                ),
                              ],
                            )
                          ]),
                        ))),
              ),
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await sendQuery(_conditions);
                  setState(() {
                    isLoading = false;
                  });
                  sendToResults(context);
                },
                elevation: 40.0,
                color: Color.fromRGBO(33, 33, 33, 0.5),
                splashColor: circleBack,
                child: Text("CLICK TO FORAGE", style: descriptionTextSmallBold),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.white)),
              )
            ]),
          ]),
    ]));
  }
}

//child:
