import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/groupes.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';

class AddGroup extends StatefulWidget {
  AddGroup({Key? key}) : super(key: key);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return turquoise;
    }

    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: brownDark,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      bottomSheet: Container(
        color: brown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));*/
                },
                child: Text('Create'),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: wi*0.7,
              child: TextField(
                decoration: textInputDecoration.copyWith(hintText: 'Name of Group'),
              ),
            ),
            
            Column(
              children: [
                CheckboxListTile(
              checkColor: Colors.white,
              title: Text('Adrien'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),

            CheckboxListTile(
              checkColor: Colors.white,
              title: Text('Adrien'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),

            CheckboxListTile(
              checkColor: Colors.white,
              title: Text('Antoine'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),

            CheckboxListTile(
              checkColor: Colors.white,
              title: Text('Mendy'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),

            CheckboxListTile(
              checkColor: Colors.white,
              title: Text('Enzo'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
              ],
            )


          ],
        ),
      ),
    );
  }
}
