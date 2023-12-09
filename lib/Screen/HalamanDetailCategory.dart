import 'package:flutter/material.dart';
import 'package:responsi_prak_mobile/Models/categories.dart';
import 'package:responsi_prak_mobile/Models/detailCategories.dart';
import 'package:responsi_prak_mobile/API_Data_Src.dart';
import 'package:responsi_prak_mobile/Screen/HalamanDetailMeals.dart';

class HalamanDetailCategory extends StatefulWidget {
  final Categories categories;
  const HalamanDetailCategory({super.key, required this.categories});

  @override
  State<HalamanDetailCategory> createState() => _HalamanDetailCategoryState();
}

class _HalamanDetailCategoryState extends State<HalamanDetailCategory> {
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
          widget.categories.strCategory!,
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 28),
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
        future: ApiDataSource.instance.getMeals(widget.categories.strCategory!),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error"),
            );
          }
          if (snapshot.hasData) {
            DetailCategory detailCategory =
                DetailCategory.fromJson(snapshot.data);
            return _buildSuccessSection(detailCategory);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildSuccessSection(DetailCategory mealsData) {
    return getListCategories(mealsData);
  }

  Widget _buildItemDetail(Meals mealsData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HalamanDetailMeals();
            },
          ));
        },
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  mealsData.strMeal!,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 28.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.network(
                    mealsData.strMealThumb!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  mealsData.idMeal!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getListCategories(DetailCategory meals) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // You can adjust the number of columns here
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: meals.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemDetail(meals.meals![index]);
      },
    );
  }
}
