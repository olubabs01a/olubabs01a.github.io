import 'package:flutter/material.dart';

void onError(BuildContext context, Exception e) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('An error occured'),
            content: Text(e.toString()),
            actions: [
              CloseButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]);
      });
}
