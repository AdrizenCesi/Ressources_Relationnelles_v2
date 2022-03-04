import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

filtersCard(double h) {
   String selectedValue = "USA";
   
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Container(
      height: h*0.07,
      color: turquoise,
      child: Row(
        children: [
          DropdownButton(
        value: selectedValue,
        style: TextStyle(color: Colors.red,fontSize: 30),
        onChanged: null,
        items: dropdownItems
      )
        ],
      ),
    ),);
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
}