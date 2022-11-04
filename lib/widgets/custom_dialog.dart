import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/constants.dart';

customDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Coming Soon!'),
        content: const Text('This feature will be coming soon!'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: whiteColor70),
              ))
        ],
      );
    },
  );
}
