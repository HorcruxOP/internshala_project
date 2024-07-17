import 'package:flutter/material.dart';
import 'package:internshala_project/functions/functions.dart';
import 'package:internshala_project/screens/search_screen.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<bool> profileCheckboxValue = [];
  List<bool> locationCheckboxValue = [];
  List<String> finalProfileList = [];
  List<String> finalLocationList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Filters"),
      ),
      body: FutureBuilder<Map<String, List<String>>>(
        future: fetchFilterData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          var profileList = snapshot.data!["profileList"]!;
          var cityList = snapshot.data!["allCityList"]!;

          if (profileCheckboxValue.isEmpty) {
            profileCheckboxValue = List<bool>.filled(profileList.length, false);
          }

          if (locationCheckboxValue.isEmpty) {
            locationCheckboxValue = List<bool>.filled(cityList.length, false);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = profileList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Checkbox(
                      activeColor: Colors.blue,
                      value: profileCheckboxValue[index],
                      onChanged: (value) {
                        setState(() {
                          profileCheckboxValue[index] = value!;
                        });
                        if (value == true) {
                          finalProfileList.add(data);
                        } else {
                          finalProfileList
                              .removeWhere((element) => element == data);
                        }
                      },
                    ),
                    title: Text(
                      data,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
              const Text(
                "Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: cityList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = cityList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Checkbox(
                      activeColor: Colors.blue,
                      value: locationCheckboxValue[index],
                      onChanged: (value) {
                        setState(() {
                          locationCheckboxValue[index] = value!;
                        });
                        if (value == true) {
                          finalLocationList.add(data);
                        } else {
                          finalLocationList
                              .removeWhere((element) => element == data);
                        }
                      },
                    ),
                    title: Text(
                      data,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {
                  setState(() {
                    profileCheckboxValue = [];
                    locationCheckboxValue = [];
                  });
                },
                child: const Text("Clear all"),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        profileList: finalProfileList,
                        locationList: finalLocationList,
                      ),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("Apply"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
