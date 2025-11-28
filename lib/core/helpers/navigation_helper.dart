import 'package:flutter/material.dart';

class NavigationHelper {
  static pushNamed({required BuildContext context, required String route}) {
    return Navigator.of(context).pushNamed(route);
  }

  static push({required BuildContext context, required Widget route}) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => route));
  }

  static pushReplacementNamed({
    required BuildContext context,
    required String route,
  }) {
    return Navigator.of(context).pushReplacementNamed(route);
  }

  static pushReplacement({
    required BuildContext context,
    required Widget route,
  }) {
    return Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => route));
  }

  static pop({required BuildContext context}) {
    return Navigator.of(context).pop();
  }
}
