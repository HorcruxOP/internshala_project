import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchInternships({
  List<String> profileList = const [],
  List<String> locationList = const [],
}) async {
  var response = await http
      .get(Uri.parse("https://internshala.com/flutter_hiring/search"));

  var decodedResponse = jsonDecode(response.body);
  var intershipIds = decodedResponse["internship_ids"];
  List<Map<String, dynamic>> internshipList = [];
  for (var element in intershipIds) {
    Map<String, dynamic> internshipData =
        decodedResponse["internships_meta"][element.toString()];
    internshipList.add(internshipData);
  }
  if (profileList.isNotEmpty) {
    internshipList = internshipList
        .where(
          (element) => profileList.any((item) =>
              item.toLowerCase() == element["title"].toString().toLowerCase()),
        )
        .toList();

    print(internshipList);
  }
  if (locationList.isNotEmpty) {
    internshipList = internshipList
        .where(
          (element) => locationList.any((item) => element["location_names"].any(
              (location) =>
                  item.toLowerCase() == location.toString().toLowerCase())),
        )
        .toList();

    print(internshipList);
  }
  return internshipList;
}

Future<Map<String, List<String>>> fetchFilterData() async {
  var intershipDataList = await fetchInternships();

  List<String> profileList = [];
  List<String> allCityList = [];

  for (var element in intershipDataList) {
    if (!(profileList.contains(element["title"]))) {
      profileList.add(element["title"]);
    }

    var cityList = element["location_names"];
    for (var city in cityList) {
      if (!(allCityList.contains(city))) {
        allCityList.add(city);
      }
    }
  }

  return {
    "profileList": profileList,
    "allCityList": allCityList,
  };
}
