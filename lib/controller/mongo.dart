import 'package:forageralpha/controller/forage_functionality.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



sendQuery(conditions) async {
 final _firestore = Firestore.instance;
 final _auth = FirebaseAuth.instance;
 final user = await _auth.currentUser();
 String userID = user.uid;

 var calorieConditions;
 var carbohydrateConditions;
 var fatConditions;
 var proteinConditions;
 var calciumConditions;
 var cholesterolConditions;
 var monounsaturatedConditions;
 var polyunsaturatedConditions;
 var saturatedConditions;
 var transConditions;
 var ironConditions;
 var fiberConditions;
 var folateConditions;
 var potassiumConditions;
 var magnesiumConditions;
 var sodiumConditions;
 var niacinb3Conditions;
 var phosphorusConditions;
 var riboflavinb2Conditions;
 var sugarsConditions;
 var thiaminb1Conditions;
 var vitamineConditions;
 var vitaminaConditions;
 var vitaminb12Conditions;
 var vitaminb6Conditions;
 var vitamincConditions;
 var vitamindConditions;
 var vitaminkConditions;

 Db db = new Db.pool([
   "mongodb://brendanhughes:LeoDalton1@foragercluster-shard-00-00.29jmm.gcp.mongodb.net:27017/foodData?ssl=true&replicaSet=atlas-7x1d28-shard-0&authSource=admin&retryWrites=true&w=majority",
   "mongodb://brendanhughes:LeoDalton1@foragercluster-shard-00-01.29jmm.gcp.mongodb.net:27017/foodData?ssl=true&replicaSet=atlas-7x1d28-shard-0&authSource=admin&retryWrites=true&w=majority",
   "mongodb://brendanhughes:LeoDalton1@foragercluster-shard-00-02.29jmm.gcp.mongodb.net:27017/foodData?ssl=true&replicaSet=atlas-7x1d28-shard-0&authSource=admin&retryWrites=true&w=majority",
 ]);

 await db.open(secure:true);
 DbCollection collection = db.collection('recipes');
 List tempResultsList = [];
 int numberOfConditionResults = 0;

 //Nutritional
 if (conditions['calorieConditions'][1] != null) {calorieConditions = conditions['calorieConditions'][1].split(' to '); var calorieConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['calorieConditions'][0],double.parse(calorieConditions[0])).and(where.lt('Nutrition.'+conditions['calorieConditions'][0],double.parse(calorieConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in calorieConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['carbohydrateConditions'][1] != null) {carbohydrateConditions = conditions['carbohydrateConditions'][1].split(' to '); var carbohydrateConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['carbohydrateConditions'][0],double.parse(carbohydrateConditions[0])).and(where.lt('Nutrition.'+conditions['carbohydrateConditions'][0],double.parse(carbohydrateConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in carbohydrateConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['fatConditions'][1] != null) {fatConditions = conditions['fatConditions'][1].split(' to '); var fatConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['fatConditions'][0],double.parse(fatConditions[0])).and(where.lt('Nutrition.'+conditions['fatConditions'][0],double.parse(fatConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in fatConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['proteinConditions'][1] != null) {proteinConditions = conditions['proteinConditions'][1].split(' to '); var proteinConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['proteinConditions'][0],double.parse(proteinConditions[0])).and(where.lt('Nutrition.'+conditions['proteinConditions'][0],double.parse(proteinConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in proteinConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['calciumConditions'][1] != null) {calciumConditions = conditions['calciumConditions'][1].split(' to '); var calciumConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['calciumConditions'][0],double.parse(calciumConditions[0])).and(where.lt('Nutrition.'+conditions['calciumConditions'][0],double.parse(calciumConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in calciumConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['cholesterolConditions'][1] != null) {cholesterolConditions = conditions['cholesterolConditions'][1].split(' to '); var cholesterolConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['cholesterolConditions'][0],double.parse(cholesterolConditions[0])).and(where.lt('Nutrition.'+conditions['cholesterolConditions'][0],double.parse(cholesterolConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in cholesterolConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['monounsaturatedConditions'][1] != null) {monounsaturatedConditions = conditions['monounsaturatedConditions'][1].split(' to '); var monounsaturatedConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['monounsaturatedConditions'][0],double.parse(monounsaturatedConditions[0])).and(where.lt('Nutrition.'+conditions['monounsaturatedConditions'][0],double.parse(monounsaturatedConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in monounsaturatedConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['polyunsaturatedConditions'][1] != null) {polyunsaturatedConditions = conditions['polyunsaturatedConditions'][1].split(' to '); var polyunsaturatedConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['polyunsaturatedConditions'][0],double.parse(polyunsaturatedConditions[0])).and(where.lt('Nutrition.'+conditions['polyunsaturatedConditions'][0],double.parse(polyunsaturatedConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in polyunsaturatedConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['saturatedConditions'][1] != null) {saturatedConditions = conditions['saturatedConditions'][1].split(' to '); var saturatedConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['saturatedConditions'][0],double.parse(saturatedConditions[0])).and(where.lt('Nutrition.'+conditions['saturatedConditions'][0],double.parse(saturatedConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in saturatedConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['transConditions'][1] != null) {transConditions = conditions['transConditions'][1].split(' to '); var transConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['transConditions'][0],double.parse(transConditions[0])).and(where.lt('Nutrition.'+conditions['transConditions'][0],double.parse(transConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in transConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['ironConditions'][1] != null) {ironConditions = conditions['ironConditions'][1].split(' to '); var ironConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['ironConditions'][0],double.parse(ironConditions[0])).and(where.lt('Nutrition.'+conditions['ironConditions'][0],double.parse(ironConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in ironConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['fiberConditions'][1] != null) {fiberConditions = conditions['fiberConditions'][1].split(' to '); var fiberConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['fiberConditions'][0],double.parse(fiberConditions[0])).and(where.lt('Nutrition.'+conditions['fiberConditions'][0],double.parse(fiberConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in fiberConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['folateConditions'][1] != null) {folateConditions = conditions['folateConditions'][1].split(' to '); var folateConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['folateConditions'][0],double.parse(folateConditions[0])).and(where.lt('Nutrition.'+conditions['folateConditions'][0],double.parse(folateConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in folateConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['potassiumConditions'][1] != null) {potassiumConditions = conditions['potassiumConditions'][1].split(' to '); var potassiumConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['potassiumConditions'][0],double.parse(potassiumConditions[0])).and(where.lt('Nutrition.'+conditions['potassiumConditions'][0],double.parse(potassiumConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in potassiumConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['magnesiumConditions'][1] != null) {magnesiumConditions = conditions['magnesiumConditions'][1].split(' to '); var magnesiumConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['magnesiumConditions'][0],double.parse(magnesiumConditions[0])).and(where.lt('Nutrition.'+conditions['magnesiumConditions'][0],double.parse(magnesiumConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in magnesiumConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['sodiumConditions'][1] != null) {sodiumConditions = conditions['sodiumConditions'][1].split(' to '); var sodiumConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['sodiumConditions'][0],double.parse(sodiumConditions[0])).and(where.lt('Nutrition.'+conditions['sodiumConditions'][0],double.parse(sodiumConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in sodiumConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['niacinb3Conditions'][1] != null) {niacinb3Conditions = conditions['niacinb3Conditions'][1].split(' to '); var niacinb3ConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['niacinb3Conditions'][0],double.parse(niacinb3Conditions[0])).and(where.lt('Nutrition.'+conditions['niacinb3Conditions'][0],double.parse(niacinb3Conditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in niacinb3ConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['phosphorusConditions'][1] != null) {phosphorusConditions = conditions['phosphorusConditions'][1].split(' to '); var phosphorusConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['phosphorusConditions'][0],double.parse(phosphorusConditions[0])).and(where.lt('Nutrition.'+conditions['phosphorusConditions'][0],double.parse(phosphorusConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in phosphorusConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['riboflavinb2Conditions'][1] != null) {riboflavinb2Conditions = conditions['riboflavinb2Conditions'][1].split(' to '); var riboflavinb2ConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['riboflavinb2Conditions'][0],double.parse(riboflavinb2Conditions[0])).and(where.lt('Nutrition.'+conditions['riboflavinb2Conditions'][0],double.parse(riboflavinb2Conditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in riboflavinb2ConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['sugarsConditions'][1] != null) {sugarsConditions = conditions['sugarsConditions'][1].split(' to '); var sugarsConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['sugarsConditions'][0],double.parse(sugarsConditions[0])).and(where.lt('Nutrition.'+conditions['sugarsConditions'][0],double.parse(sugarsConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in sugarsConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['thiaminb1Conditions'][1] != null) {thiaminb1Conditions = conditions['thiaminb1Conditions'][1].split(' to '); var thiaminb1ConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['thiaminb1Conditions'][0],double.parse(thiaminb1Conditions[0])).and(where.lt('Nutrition.'+conditions['thiaminb1Conditions'][0],double.parse(thiaminb1Conditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in thiaminb1ConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitamineConditions'][1] != null) {vitamineConditions = conditions['vitamineConditions'][1].split(' to '); var vitamineConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitamineConditions'][0],double.parse(vitamineConditions[0])).and(where.lt('Nutrition.'+conditions['vitamineConditions'][0],double.parse(vitamineConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitamineConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitaminaConditions'][1] != null) {vitaminaConditions = conditions['vitaminaConditions'][1].split(' to '); var vitaminaConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitaminaConditions'][0],double.parse(vitaminaConditions[0])).and(where.lt('Nutrition.'+conditions['vitaminaConditions'][0],double.parse(vitaminaConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitaminaConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitaminb12Conditions'][1] != null) {vitaminb12Conditions = conditions['vitaminb12Conditions'][1].split(' to '); var vitaminb12ConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitaminb12Conditions'][0],double.parse(vitaminb12Conditions[0])).and(where.lt('Nutrition.'+conditions['vitaminb12Conditions'][0],double.parse(vitaminb12Conditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitaminb12ConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitaminb6Conditions'][1] != null) {vitaminb6Conditions = conditions['vitaminb6Conditions'][1].split(' to '); var vitaminb6ConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitaminb6Conditions'][0],double.parse(vitaminb6Conditions[0])).and(where.lt('Nutrition.'+conditions['vitaminb6Conditions'][0],double.parse(vitaminb6Conditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitaminb6ConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitamincConditions'][1] != null) {vitamincConditions = conditions['vitamincConditions'][1].split(' to '); var vitamincConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitamincConditions'][0],double.parse(vitamincConditions[0])).and(where.lt('Nutrition.'+conditions['vitamincConditions'][0],double.parse(vitamincConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitamincConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitamindConditions'][1] != null) {vitamindConditions = conditions['vitamindConditions'][1].split(' to '); var vitamindConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitamindConditions'][0],double.parse(vitamindConditions[0])).and(where.lt('Nutrition.'+conditions['vitamindConditions'][0],double.parse(vitamindConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitamindConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}
 if (conditions['vitaminkConditions'][1] != null) {vitaminkConditions = conditions['vitaminkConditions'][1].split(' to '); var vitaminkConditionsResults = await collection.find((where.gt('Nutrition.'+conditions['vitaminkConditions'][0],double.parse(vitaminkConditions[0])).and(where.lt('Nutrition.'+conditions['vitaminkConditions'][0],double.parse(vitaminkConditions[1]))).limit(5000).sortBy('Favorites',descending: true))).toList(); for (var item in vitaminkConditionsResults) {tempResultsList.add(item);} numberOfConditionResults ++;}

//Dietary Conditions
 var listOfCategories = [];
 if(conditions['diabeticFriendlyConditions'][1]==true) {listOfCategories.add(conditions['diabeticFriendlyConditions'][0]);}
 if(conditions['heartHealthyConditions'][1]==true) {listOfCategories.add(conditions['heartHealthyConditions'][0]);}
 if(conditions['highFiberConditions'][1]==true) {listOfCategories.add(conditions['highFiberConditions'][0]);}
 if(conditions['highProteinConditions'][1]==true) {listOfCategories.add(conditions['highProteinConditions'][0]);}
 if(conditions['lowCarbConditions'][1]==true) {listOfCategories.add(conditions['lowCarbConditions'][0]);}
 if(conditions['lowFatConditions'][1]==true) {listOfCategories.add(conditions['lowFatConditions'][0]);}
 if(conditions['lowFODMAPConditions'][1]==true) {listOfCategories.add(conditions['lowFODMAPConditions'][0]);}
 if(conditions['glutenFreeConditions'][1]==true) {listOfCategories.add(conditions['glutenFreeConditions'][0]);}
 if(conditions['ketogenicConditions'][1]==true) {listOfCategories.add(conditions['ketogenicConditions'][0]);}
 if(conditions['dairyFreeConditions'][1]==true) {listOfCategories.add(conditions['dairyFreeConditions'][0]);}
 if(conditions['lowSaltConditions'][1]==true) {listOfCategories.add(conditions['lowSaltConditions'][0]);}
 if(conditions['lowSugarConditions'][1]==true) {listOfCategories.add(conditions['lowSugarConditions'][0]);}
 if(conditions['paleoConditions'][1]==true) {listOfCategories.add(conditions['paleoConditions'][0]);}
 if(conditions['veganConditions'][1]==true) {listOfCategories.add(conditions['veganConditions'][0]);}
 if(conditions['vegetarianConditions'][1]==true) {listOfCategories.add(conditions['vegetarianConditions'][0]);}
 if(conditions['eggFreeConditions'][1]==true) {listOfCategories.add(conditions['eggFreeConditions'][0]);}
 if(conditions['fishFreeConditions'][1]==true) {listOfCategories.add(conditions['fishFreeConditions'][0]);}
 if(conditions['balancedConditions'][1]==true) {listOfCategories.add(conditions['balancedConditions'][0]);}
 if(conditions['cleanEatingConditions'][1]==true) {listOfCategories.add(conditions['cleanEatingConditions'][0]);}
 if(conditions['peanutFreeConditions'][1]==true) {listOfCategories.add(conditions['peanutFreeConditions'][0]);}
 if(conditions['porkFreeConditions'][1]==true) {listOfCategories.add(conditions['porkFreeConditions'][0]);}
 if(conditions['redMeatFreeConditions'][1]==true) {listOfCategories.add(conditions['redMeatFreeConditions'][0]);}
 if(conditions['sesameFreeConditions'][1]==true) {listOfCategories.add(conditions['sesameFreeConditions'][0]);}
 if(conditions['shellfishFreeConditions'][1]==true) {listOfCategories.add(conditions['shellfishFreeConditions'][0]);}
 if(conditions['soyFreeConditions'][1]==true) {listOfCategories.add(conditions['soyFreeConditions'][0]);}
 if(conditions['treenutFreeConditions'][1]==true) {listOfCategories.add(conditions['treenutFreeConditions'][0]);}
//Dishes
 if(conditions['breadsDishCondition'][1]==true) {listOfCategories.add(conditions['breadsDishCondition'][0]);}
 if(conditions['cakesDishCondition'][1]==true) {listOfCategories.add(conditions['cakesDishCondition'][0]);}
 if(conditions['candyDishCondition'][1]==true) {listOfCategories.add(conditions['candyDishCondition'][0]);}
 if(conditions['casseroleDishCondition'][1]==true) {listOfCategories.add(conditions['casseroleDishCondition'][0]);}
 if(conditions['cocktailDishCondition'][1]==true) {listOfCategories.add(conditions['cocktailDishCondition'][0]);}
 if(conditions['cookieDishCondition'][1]==true) {listOfCategories.add(conditions['cookieDishCondition'][0]);}
 if(conditions['macandcheeseDishCondition'][1]==true) {listOfCategories.add(conditions['macandcheeseDishCondition'][0]);}
 if(conditions['mainDishesCondition'][1]==true) {listOfCategories.add(conditions['mainDishesCondition'][0]);}
 if(conditions['pastaSaladDishCondition'][1]==true) {listOfCategories.add(conditions['pastaSaladDishCondition'][0]);}
 if(conditions['pastaDishCondition'][1]==true) {listOfCategories.add(conditions['pastaDishCondition'][0]);}
 if(conditions['pieDishCondition'][1]==true) {listOfCategories.add(conditions['pieDishCondition'][0]);}
 if(conditions['pizzaDishCondition'][1]==true) {listOfCategories.add(conditions['pizzaDishCondition'][0]);}
 if(conditions['sandwichDishCondition'][1]==true) {listOfCategories.add(conditions['sandwichDishCondition'][0]);}
 if(conditions['saucesDishCondition'][1]==true) {listOfCategories.add(conditions['saucesDishCondition'][0]);}
 if(conditions['smoothiesDishCondition'][1]==true) {listOfCategories.add(conditions['smoothiesDishCondition'][0]);}
 if(conditions['soupsDishCondition'][1]==true) {listOfCategories.add(conditions['soupsDishCondition'][0]);}
 if(conditions['bbqDishCondition'][1]==true) {listOfCategories.add(conditions['bbqDishCondition'][0]);}
 if(conditions['kidsDishCondition'][1]==true) {listOfCategories.add(conditions['kidsDishCondition'][0]);}
 if(conditions['forTwoDishCondition'][1]==true) {listOfCategories.add(conditions['forTwoDishCondition'][0]);}
 if(conditions['budgetDishCondition'][1]==true) {listOfCategories.add(conditions['budgetDishCondition'][0]);}
 if(conditions['pressureCookerDishCondition'][1]==true) {listOfCategories.add(conditions['pressureCookerDishCondition'][0]);}
 if(conditions['quickEasyDishCondition'][1]==true) {listOfCategories.add(conditions['quickEasyDishCondition'][0]);}
 if(conditions['slowCookerDishCondition'][1]==true) {listOfCategories.add(conditions['slowCookerDishCondition'][0]);}
 //Meal Type
 if(conditions['breakfastAndBrunchConditions'][1]==true) {listOfCategories.add(conditions['breakfastAndBrunchConditions'][0]);}
 if(conditions['dinnerConditions'][1]==true) {listOfCategories.add(conditions['dinnerConditions'][0]);}
 if(conditions['dessertsConditions'][1]==true) {listOfCategories.add(conditions['dessertsConditions'][0]);}
 if(conditions['lunchConditions'][1]==true) {listOfCategories.add(conditions['lunchConditions'][0]);}
 if(conditions['entertainingPartiesConditions'][1]==true) {listOfCategories.add(conditions['entertainingPartiesConditions'][0]);}
 //Cuisines
 if(conditions['africanConditions'][1]==true) {listOfCategories.add(conditions['africanConditions'][0]);}
 if(conditions['americanConditions'][1]==true) {listOfCategories.add(conditions['americanConditions'][0]);}
 if(conditions['argentinianConditions'][1]==true) {listOfCategories.add(conditions['argentinianConditions'][0]);}
 if(conditions['australianConditions'][1]==true) {listOfCategories.add(conditions['australianConditions'][0]);}
 if(conditions['austrianConditions'][1]==true) {listOfCategories.add(conditions['austrianConditions'][0]);}
 if(conditions['bangladeshiConditions'][1]==true) {listOfCategories.add(conditions['bangladeshiConditions'][0]);}
 if(conditions['belgianConditions'][1]==true) {listOfCategories.add(conditions['belgianConditions'][0]);}
 if(conditions['brazilianConditions'][1]==true) {listOfCategories.add(conditions['brazilianConditions'][0]);}
 if(conditions['canadianConditions'][1]==true) {listOfCategories.add(conditions['canadianConditions'][0]);}
 if(conditions['chileanConditions'][1]==true) {listOfCategories.add(conditions['chileanConditions'][0]);}
 if(conditions['chineseConditions'][1]==true) {listOfCategories.add(conditions['chineseConditions'][0]);}
 if(conditions['colombianConditions'][1]==true) {listOfCategories.add(conditions['colombianConditions'][0]);}
 if(conditions['cubanConditions'][1]==true) {listOfCategories.add(conditions['cubanConditions'][0]);}
 if(conditions['dutchConditions'][1]==true) {listOfCategories.add(conditions['dutchConditions'][0]);}
 if(conditions['easternEuropeanConditions'][1]==true) {listOfCategories.add(conditions['easternEuropeanConditions'][0]);}
 if(conditions['filipinoConditions'][1]==true) {listOfCategories.add(conditions['filipinoConditions'][0]);}
 if(conditions['frenchConditions'][1]==true) {listOfCategories.add(conditions['frenchConditions'][0]);}
 if(conditions['germanConditions'][1]==true) {listOfCategories.add(conditions['germanConditions'][0]);}
 if(conditions['greekConditions'][1]==true) {listOfCategories.add(conditions['greekConditions'][0]);}
 if(conditions['indianConditions'][1]==true) {listOfCategories.add(conditions['indianConditions'][0]);}
 if(conditions['indonesianConditions'][1]==true) {listOfCategories.add(conditions['indonesianConditions'][0]);}
 if(conditions['israeliConditions'][1]==true) {listOfCategories.add(conditions['israeliConditions'][0]);}
 if(conditions['italianConditions'][1]==true) {listOfCategories.add(conditions['italianConditions'][0]);}
 if(conditions['jamaicanConditions'][1]==true) {listOfCategories.add(conditions['jamaicanConditions'][0]);}
 if(conditions['japaneseConditions'][1]==true) {listOfCategories.add(conditions['japaneseConditions'][0]);}
 if(conditions['koreanConditions'][1]==true) {listOfCategories.add(conditions['koreanConditions'][0]);}
 if(conditions['lebaneseConditions'][1]==true) {listOfCategories.add(conditions['lebaneseConditions'][0]);}
 if(conditions['malaysianConditions'][1]==true) {listOfCategories.add(conditions['malaysianConditions'][0]);}
 if(conditions['mediterraneanConditions'][1]==true) {listOfCategories.add(conditions['mediterraneanConditions'][0]);}
 if(conditions['mexicanConditions'][1]==true) {listOfCategories.add(conditions['mexicanConditions'][0]);}
 if(conditions['pakistaniConditions'][1]==true) {listOfCategories.add(conditions['pakistaniConditions'][0]);}
 if(conditions['persianConditions'][1]==true) {listOfCategories.add(conditions['persianConditions'][0]);}
 if(conditions['peruvianConditions'][1]==true) {listOfCategories.add(conditions['peruvianConditions'][0]);}
 if(conditions['portugueseConditions'][1]==true) {listOfCategories.add(conditions['portugueseConditions'][0]);}
 if(conditions['puertoRicanConditions'][1]==true) {listOfCategories.add(conditions['puertoRicanConditions'][0]);}
 if(conditions['scandinavianConditions'][1]==true) {listOfCategories.add(conditions['scandinavianConditions'][0]);}
 if(conditions['southernConditions'][1]==true) {listOfCategories.add(conditions['southernConditions'][0]);}
 if(conditions['spanishConditions'][1]==true) {listOfCategories.add(conditions['spanishConditions'][0]);}
 if(conditions['swissConditions'][1]==true) {listOfCategories.add(conditions['swissConditions'][0]);}
 if(conditions['thaiConditions'][1]==true) {listOfCategories.add(conditions['thaiConditions'][0]);}
 if(conditions['turkishConditions'][1]==true) {listOfCategories.add(conditions['turkishConditions'][0]);}
 if(conditions['ukIrishConditions'][1]==true) {listOfCategories.add(conditions['ukIrishConditions'][0]);}
 if(conditions['vietnameseConditions'][1]==true) {listOfCategories.add(conditions['vietnameseConditions'][0]);}
 Map finalMap ={};
 Map countMap = {};
 List favoriteRanks = [];

 var categoryResults = await collection.find(where.all("Categories", listOfCategories)).toList();
 numberOfConditionResults ++;
 for (var item in categoryResults) {
  tempResultsList.add(item);
 }

 tempResultsList.forEach((element) {
  if(!countMap.containsKey(element["ID"])) {
   countMap[element["ID"]] = 1;
  } else {
   countMap[element["ID"]] +=1;
  }
 });

 for (var item in tempResultsList) {
  if (countMap[item["ID"]] == numberOfConditionResults) {
   if (!finalMap.containsKey(item["ID"])) {
    var recipeData = {"ID":item["ID"],"Title":item["Title"],"Ingredients":item["Ingredients"],"Instructions":item["Instructions"],"Favorites":item["Favorites"],"Image":item["Image"],"Prep Time":item["Prep Time"],"Cook Time":item["Cook Time"],"Nutrition":item["Nutrition"],"Total Time":item["Total Time"],"Servings":item["Servings"],"Yield":item["Yield"]};
    finalMap[item["ID"]] = recipeData;
    favoriteRanks.add(item["Favorites"]);
   }
  }
 }

 if (finalMap.length > 30){
  favoriteRanks.sort();
  var cutoff = favoriteRanks.sublist(favoriteRanks.length - 30,favoriteRanks.length);
  var low = cutoff[0];
  finalMap.removeWhere((key, value) => value["Favorites"] < low);
 };

var queryID = userID + "-Q-" + DateTime.now().toString();

 var userData = await getUserData();
 userData["currentQueryID"] = queryID;
 await _firestore.collection("userData").document(userID).updateData(userData);

var queryData = {"QueryID":queryID,
 "Conditions": conditions,
 "Results":finalMap,
 "QueryTime":DateTime.now().toString()};

 await _firestore
     .collection('findFoodQueryResults')
     .document(queryID).setData(queryData);
}

 //TODO: Take in conditions, create a series of if/else statements to check and assign values to each possible condition.
 //TODO: Use the conditional variables you've set above to create a query statement that will yield correct results.
 //TODO: Store results in Firebase collection that will be accessed by the Streambuilder on the results page.
 //TODO: Update tracking in Firebase - i.e. increase "Times Found" by 1 for each recipe. Update user profile to increment list of found foods and previous queries.


updateLikesInMongo(recipe,state) async {
 Db db = new Db.pool([
  "mongodb://brendanhughes:LeoDalton1@foragercluster-shard-00-00.29jmm.gcp.mongodb.net:27017/foodData?ssl=true&replicaSet=atlas-7x1d28-shard-0&authSource=admin&retryWrites=true&w=majority",
  "mongodb://brendanhughes:LeoDalton1@foragercluster-shard-00-01.29jmm.gcp.mongodb.net:27017/foodData?ssl=true&replicaSet=atlas-7x1d28-shard-0&authSource=admin&retryWrites=true&w=majority",
  "mongodb://brendanhughes:LeoDalton1@foragercluster-shard-00-02.29jmm.gcp.mongodb.net:27017/foodData?ssl=true&replicaSet=atlas-7x1d28-shard-0&authSource=admin&retryWrites=true&w=majority",
 ]);
 await db.open(secure:true);
 DbCollection collection = db.collection('recipes');

 if (state == true) {
  collection.update(where.eq('ID',recipe),modify.inc('Favorites', 1));
 }
 if (state == false) {
  collection.update(where.eq('ID',recipe),modify.inc('Favorites', -1));
 }
}