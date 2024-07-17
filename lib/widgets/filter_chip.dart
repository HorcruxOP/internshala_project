import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  final List list;
  const CustomFilterChip({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Chip(
              padding: const EdgeInsets.only(bottom: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              backgroundColor: Colors.white,
              label: Center(
                child: Text(
                  list[index],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
