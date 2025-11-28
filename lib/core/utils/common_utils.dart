import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> getDropdownItems(List<String> list) {
  var dropdownList =
      list.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();
  return dropdownList;
}
