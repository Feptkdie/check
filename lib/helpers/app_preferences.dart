import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

void showSnackBar(String value, GlobalKey<ScaffoldState> key) {
  key.currentState!.showSnackBar(
    SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 1),
    ),
  );
}

loading(bool status, BuildContext context) {
  if (status == true) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text("Loading"),
            ],
          ),
        );
      },
    );
  } else {
    Navigator.pop(context);
  }
}

// void showMessage(
//   String message,
//   Color backgroundColor,
//   Color textColor,
// ) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: backgroundColor,
//     textColor: textColor,
//     fontSize: 16.0,
//   );
// }
