import 'package:flutter/material.dart';
//import 'package:responsi_prak_mobile/Models/meals.dart';

class HalamanDetailMeals extends StatefulWidget {
  //final Meals meals;
  const HalamanDetailMeals({super.key});

  @override
  State<HalamanDetailMeals> createState() => _HalamanDetailMealsState();
}

class _HalamanDetailMealsState extends State<HalamanDetailMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Center(
        child: Text("Detail"),
      ),
    );
  }
}
