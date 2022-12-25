import 'package:flutter/material.dart';
import 'package:pelatihanflutter/dbhelper/dbhelper.dart';
import 'package:pelatihanflutter/main.dart';
import 'package:pelatihanflutter/model/meal.dart';
import 'package:pelatihanflutter/ui/pages/profile_screen.dart';

class AddMeal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mealController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _kiloController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _prepareController = TextEditingController();

  List<Map<String, dynamic>> meal = [];

  String data;
  Future saveMeal() async {
    final response = await SQLHelper.getMeal(
        _mealController.text,
        _nameController.text,
        _kiloController.text,
        _timeController.text,
        _imageController.text,
        _ingredientsController.text,
        _prepareController.text);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
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
