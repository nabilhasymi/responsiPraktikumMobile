import 'package:flutter/material.dart';
import 'package:responsi_prak_mobile/Models/meals.dart';
import 'package:responsi_prak_mobile/API_Data_Src.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanDetailMeals extends StatefulWidget {
  final String meals;
  const HalamanDetailMeals({super.key, required this.meals});

  @override
  State<HalamanDetailMeals> createState() => _HalamanDetailMealsState();
}

class _HalamanDetailMealsState extends State<HalamanDetailMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 227, 206, 1.0),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
        title: Text(
          "Details",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildListMeals(),
    );
  }

  Widget _buildListMeals() {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: FutureBuilder(
        future: ApiDataSource.instance.getDetails(widget.meals),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error"),
            );
          }
          if (snapshot.hasData) {
            DetailModel detailModel = DetailModel.fromJson(snapshot.data);
            return _buildSuccessSection(detailModel);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildSuccessSection(DetailModel meals) {
    return Center(child: getListCategories(meals));
  }

  getListCategories(DetailModel meals) {
    return ListView.builder(
      itemCount: meals.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemDetail(meals.meals![index]);
      },
    );
  }

  Widget _buildItemDetail(Meals meals) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              meals.strMealThumb!,
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            meals.strMeal!,
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 28.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  "Category: " + meals.strCategory!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  "Area: " + meals.strArea!,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            "Ingredients:",
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 20.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(meals.strIngredient1!),
              Text(meals.strIngredient2!),
              Text(meals.strIngredient3!),
              Text(meals.strIngredient4!),
              Text(meals.strIngredient5!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            "Instructions:",
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 20.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            meals.strInstructions!,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton.icon(
            onPressed: () {
              _launchURL(meals.strYoutube!);
            },
            icon: Icon(Icons.play_arrow),
            label: Text("Watch Tutorial"),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(115, 144, 114, 1.0),
              elevation: 4,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
