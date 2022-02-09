import 'package:flutter/material.dart';
import 'package:practice/User.dart';

class Preview extends StatefulWidget {
  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController nationalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(top: 10.0),
            height: 500.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
            child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Enter Firstname',
                        ),
                      ),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Enter Lastname',
                        ),
                      ),
                      TextField(
                        controller: nationalityController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Enter Nationality',
                        ),
                      ),
                      Center(
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(),
                            label: Text('Add Contact'),
                            onPressed: () {
                              users.add(User(
                                nationality: nationalityController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                              ));
                              Navigator.pop(context);
                              setState(() {});
                            },
                            icon: (Icon(Icons.person_add_outlined))),
                      ),
                      SizedBox(height: 100.0),
                    ]))));
  }
}
