import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/widgets/tile_reminder.dart';

class HomeReminderList extends StatelessWidget{
  const HomeReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of columns in the grid
          crossAxisSpacing: 8.0, // Set the spacing between columns
          mainAxisSpacing: 8.0, // Set the spacing between rows
        ),
        itemCount: 18, // Set the number of items in the grid
        itemBuilder: (context, index) {
          return TileReminder();
        },
      ),
    );
  }
}