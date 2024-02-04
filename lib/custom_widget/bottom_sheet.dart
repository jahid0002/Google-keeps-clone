import 'package:flutter/material.dart';

class AddBottomSheet {
  static showBotomSheet(
      {required BuildContext context, required List<Widget> children}) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              children: children,
            ),
          );
        });
  }
}
