import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pelatihanflutter/main.dart';
import 'package:pelatihanflutter/ui/pages/profile_screen.dart';
import 'package:http/http.dart' as http;

class AddMeal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mealController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _kiloController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _prepareController = TextEditingController();

  Future saveMeal() async {
    final response =
        await http.post(Uri.parse("http://127.0.0.1:8000/api/meal"), body: {
      "meal time": _mealController.text,
      "name": _nameController.text,
      "kilo calories burnt": _kiloController.text,
      "time": _timeController.text,
      "image URL": _imageController.text,
      "ingredients": _ingredientsController.text,
      "preparation": _prepareController.text
    });
    print(response.body);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var data = "Save";
    return Scaffold(
      appBar: AppBar(
        title: Text("Add meal"),
      ),
      body: Center(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: _mealController,
                decoration: InputDecoration(labelText: "Meal Time"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter meal time";
                  }
                  return null;
                }),
            TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                }),
            TextFormField(
                controller: _kiloController,
                decoration: InputDecoration(labelText: "Kilo Calories Burnt"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter kilo calories burnt";
                  }
                  return null;
                }),
            TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: "Time Taken"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter time taken";
                  }
                  return null;
                }),
            TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "Image URL"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter image URL";
                  }
                  return null;
                }),
            TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(labelText: "Ingredients"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter ingredients";
                  }
                  return null;
                }),
            TextFormField(
                controller: _prepareController,
                decoration: InputDecoration(labelText: "Preparation"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter preparation";
                  }
                  return null;
                }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    saveMeal().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    });
                  }
                },
                child: Text(data))
          ],
        ),
      ),
    );
  }
}
