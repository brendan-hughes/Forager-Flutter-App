import 'package:csv/csv.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

loadAsset() async {
  print("Loading");
  bool isFirst = true;
  final myData = await rootBundle.loadString(
    "");
  print("Read CSV");
  List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
  print("Converted CSV");
  var number = 1;
  for (var row in csvTable) {
    if (isFirst != true) {
          final ID = row[0];
          var idSplitter = double.parse(ID.split("-")[1]);
          if (idSplitter >= 67950)
          { if (idSplitter <= 73000) {
            final CategoriesString = row[1];
          final CategoriesString1 = CategoriesString.split(",");
          List Categories = [];
          for (var item in CategoriesString1) {
            item = item.replaceAll("[", "");
            item = item.replaceAll("]", "");
            item = item.replaceAll("'", "");
            item = item.replaceAll('"', "");
            Categories.add(item.trim());
          }
          final Title = row[2];
          final URL = row[3];

          final IngredientsString = row[4];
          final IngredientsString1 = IngredientsString.split(",");
          List Ingredients = [];

          for (var item in IngredientsString1) {
            item = item.replaceAll("[", "");
            item = item.replaceAll("]", "");
            item = item.replaceAll("'", "");
            item = item.replaceAll('"', "");
            item = item.replaceAll((r'1\u2009'), "");
            item = item.replaceAll((r'2\u2009'), "");
            var scan = item;
            bool include = false;
            for (int i = 0; i < scan.length; i++) {
              var char = scan[i];
              if (isNumeric(char) == true) {
                include = true;
              }
              if (char == "½") {
                include = true;
              }
              if (char == "⅓") {
                include = true;
              }
              if (char == "⅔") {
                include = true;
              }
              if (char == "¼") {
                include = true;
              }
              if (char == "¾") {
                include = true;
              }
              if (char == "⅕") {
                include = true;
              }
              if (char == "⅖") {
                include = true;
              }
              if (char == "⅗") {
                include = true;
              }
              if (char == "⅘") {
                include = true;
              }
              if (char == "⅙") {
                include = true;
              }
              if (char == "⅚") {
                include = true;
              }
              if (char == "⅙") {
                include = true;
              }
              if (char == "⅜") {
                include = true;
              }
              if (char == "⅝") {
                include = true;
              }
              if (char == "⅞") {
                include = true;
              }
            }
            if (include == true) {
              Ingredients.add(item.trim());
            }
          }
          var InstructionsString = row[5].split(RegExp(":|',"));
          Map Instructions = {};
          var stepNumber = 0;
          for (var item in InstructionsString) {
            item = item.replaceAll("{", "");
            item = item.replaceAll("}", "");
            item = item.replaceAll("'", "");
            item = item.replaceAll('"', "");
            item = item.replaceAll(":", "");

            if (item.contains("Step") == true) {
              stepNumber = stepNumber + 1;
              Instructions["Step " + stepNumber.toString()] = null;
            }
            else if (item.contains("Step") != true) {
              Instructions["Step " + stepNumber.toString()] = item.trim();
            }
          }

          var NutritionString = row[6].split(RegExp(":|,"));
          final Nutrition = {};
          var listOfNutrients = ['Calcium','CalciumMeasure','Carbohydrates','CarbohydratesMeasure','Cholesterol','CholesterolMeasure','Fat','FatMeasure','Fiber','FiberMeasure','Folate','FolateMeasure','Iron','IronMeasure','Magnesium','magnesiumMeasure','MonosaturatedFat','MonosaturatedFatMeasure','VitaminB3','VitaminB3Measure','Phosphorus','PhosphorusMeasure','PolyunsaturatedFat','PolyunsaturatedFatMeasure','Potassium','PotassiumMeasure','Protein','ProteinMeasure','VitaminB2','VitaminB2Measure','SaturatedFat','SaturatedFatMeasure','Sodium','SodiumMeasure','Sugar','SugarMeasure','VitaminB1','VitaminB1Measure','TransFat','TransFatMeasure','VitaminA','VitaminAMeasure','VitaminB12','VitaminB12Measure','VitaminB6','VitaminB6Measure','VitaminC','VitaminCMeasure','VitaminD','VitaminDMeasure','VitaminE','VitaminEMeasure','VitaminK','VitaminKMeasure'];
          var index = 0;
          for (var item in NutritionString) {
            item = item.replaceAll("{", "");
            item = item.replaceAll("}", "");
            item = item.replaceAll("'", "");
            item = item.replaceAll('"', "");
            item = item.replaceAll(":", "");
            item = item.trim();

            if (listOfNutrients.contains(item)){
              var value = NutritionString[index+1];
              value = value.replaceAll("{", "");
              value = value.replaceAll("}", "");
              value = value.replaceAll("'", "");
              value = value.replaceAll('"', "");
              value = value.replaceAll(":", "");
              value = value.trim();
              if (isNumeric(value)) {
                value = double.parse(value);
              }
              Nutrition[item] = value;
            }
            index = index + 1;

          }
          print(Nutrition);

            final ImageURL = row[14];
            final cookTime = row[9];
            final totalTime = row[10];
            final servings = row[11];
            final prepTime = row[12];
            final Yield = row[13];
            final Favorites = row[15];

            _firestore.collection('recipeData').document(ID).setData({
              'ID': ID,
              'Title': Title,
              'Categories': Categories,
              'URL': URL,
              'Ingredients': Ingredients,
              'Instructions': Instructions,
              'Nutrition': Nutrition,
              'ImageURL': ImageURL,
              'Cook Time': cookTime,
              'Total Time': totalTime,
              'Servings': servings,
              'Prep Time': prepTime,
              'Yield': Yield,
              'Favorites': Favorites
            });
          print(ID);
          print("Remaining: " + (number / 70598).toString());
            number = number + 1;
            sleep(Duration(milliseconds: 250));
          }}
      }
    isFirst = false;
  }

  }


bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}