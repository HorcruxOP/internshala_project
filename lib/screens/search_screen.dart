import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshala_project/screens/filters_screen.dart';
import 'package:internshala_project/functions/functions.dart';
import 'package:internshala_project/widgets/filter_chip.dart';

class SearchScreen extends StatefulWidget {
  final List<String> profileList, locationList;
  const SearchScreen({
    super.key,
    this.profileList = const [],
    this.locationList = const [],
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Internships"),
      ),
      body: FutureBuilder(
        future: fetchInternships(
            profileList: widget.profileList, locationList: widget.locationList),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      textColor: Colors.blue,
                      height: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const FiltersScreen(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            size: 18,
                          ),
                          Text(
                            "Filters",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    widget.profileList.isNotEmpty ||
                            widget.locationList.isNotEmpty
                        ? CustomFilterChip(
                            list: widget.profileList
                              ..addAll(widget.locationList))
                        : const SizedBox(),
                    widget.profileList.isNotEmpty ||
                            widget.locationList.isNotEmpty
                        ? MaterialButton(
                            onPressed: () {
                              widget.profileList.clear();
                              widget.locationList.clear();
                              setState(() {});
                            },
                            child: const Text("Clear filters"),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              snapshot.data!.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error),
                          Text("No internship available"),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["title"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(data["company_name"]),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey.shade700,
                                      size: 20,
                                    ),
                                    Text(
                                      !data["work_from_home"]
                                          ? data["location_names"]
                                              .toString()
                                              .split("[")
                                              .last
                                              .split("]")
                                              .first
                                          : "Work from home",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.play_circle_outline_rounded,
                                      color: Colors.grey.shade700,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(data["start_date"]),
                                    const SizedBox(width: 20),
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.grey.shade700,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(data["duration"]),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.money_outlined,
                                      color: Colors.grey.shade700,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(data["stipend"]["salary"]),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: Colors.grey.shade300,
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "Intership ${data["ppo_label_value"].toString().toLowerCase()}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {},
                                      textColor: Colors.blue,
                                      child: const Text(
                                        "View details",
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Colors.blue,
                                      height: 30,
                                      textColor: Colors.white,
                                      onPressed: () {},
                                      child: const Text(
                                        "Apply now",
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
