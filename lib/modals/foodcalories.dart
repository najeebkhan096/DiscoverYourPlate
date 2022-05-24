import 'dart:convert';

import 'package:http/http.dart' as http;

class FoodCalories {
  final String? foodname;
  final String? photo;
  final String? brand_name;
  String ? nf_calories;

  FoodCalories({this.photo, this.foodname, this.brand_name, this.nf_calories});

  Future<List<FoodCalories>> getFoodDetails({String? title}) async {
    List<FoodCalories> items = [];

    final result = await http.get(
      Uri.parse(
          "https://trackapi.nutritionix.com/v2/search/instant?query=${title}"),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-app-id': '72bc8a45',
        'x-app-key': '06e3d1294b8db1136161803a14eb0573',
      },
    );

    final data = jsonDecode(result.body);
    List<dynamic> brandedData = data['branded'];


    brandedData.forEach((element) {

      items.add(FoodCalories(
          foodname: element['food_name'].toString(),
          brand_name: element['brand_name'],
          photo: element['photo']['thumb'],
          nf_calories: element['nf_calories'].toString()));
    });

    return items;
  }
}
FoodCalories foodData=FoodCalories();