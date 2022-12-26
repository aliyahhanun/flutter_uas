import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pelatihanflutter/model/meal.dart';

import '../ui/pages/profile_screen.dart';

class searchPage extends StatefulWidget {
  const searchPage({Key key}) : super(key: key);

  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  List<Meal> filteredMeal = [];
  final FocusNode _textFocusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  var mListTitleStyle;
  var mListContentStyle;
  var mListNameStyle;

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE9E9E9),
          title: Container(
            width: double.infinity,
            child: Center(
              child: TextField(
                autofocus: true,
                controller: _textEditingController,
                focusNode: _textFocusNode,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _textEditingController.clear();
                        setState(() {
                          filteredMeal = [];
                        });
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
                onChanged: (val) {
                  setState(() {
                    if (val == "") {
                      filteredMeal = [];
                    } else {
                      filteredMeal = meals
                          .where((el) => (el.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              el.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              el.mealTime
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              el.kiloCaloriesBurnt
                                  .toLowerCase()
                                  .contains(val.toLowerCase())))
                          .toList();
                    }
                  });
                },
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: _textEditingController.text.isNotEmpty &&
                          filteredMeal.length == 0
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/404.jpg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                'Data tidak ditemukan. Masukkan keyword lainnya!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _textEditingController.text.isNotEmpty &&
                                  filteredMeal.length == 0
                              ? meals.length
                              : filteredMeal.length,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                width: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    _textEditingController.text
                                                                .isNotEmpty &&
                                                            filteredMeal
                                                                    .length ==
                                                                0
                                                        ? meals[index].imagePath
                                                        : filteredMeal[index]
                                                            .imagePath),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: SvgPicture.asset(
                                            'assets/bottom_gradient.svg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          left: 8,
                                          child: Text(
                                            _textEditingController
                                                        .text.isNotEmpty &&
                                                    filteredMeal.length == 0
                                                ? meals[index].name
                                                : filteredMeal[index].name,
                                            style: mListTitleStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _textEditingController.text.isNotEmpty &&
                                              filteredMeal.length == 0
                                          ? meals[index].preparation
                                          : filteredMeal[index].preparation,
                                      maxLines: 2,
                                      style: mListContentStyle,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _textEditingController.text.isNotEmpty &&
                                              filteredMeal.length == 0
                                          ? meals[index].name
                                          : filteredMeal[index].name,
                                      style: mListNameStyle,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                        // _textEditingController
                                        //             .text.isNotEmpty &&
                                        //         filteredMeal.length == 0
                                        //     ? meals[index].id
                                        //     : filteredMeal[index].id,
                                        // 'meal'),
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
