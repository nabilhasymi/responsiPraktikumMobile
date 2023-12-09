import 'package:flutter/material.dart';
import 'package:responsi_prak_mobile/API_Data_Src.dart';
import 'package:responsi_prak_mobile/Models/categories.dart';
import 'package:responsi_prak_mobile/Screen/HalamanDetailCategory.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
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
          "Meal Categories",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildListMeals(),
    );
  }

  Widget _buildListMeals() {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: FutureBuilder(
        future: ApiDataSource.instance.getCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR"),
            );
          }
          if (snapshot.hasData) {
            CategoriesModel categoriesModel =
                CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(categoriesModel);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildSuccessSection(CategoriesModel categoriesData) {
    return getListCategories(categoriesData);
  }

  Widget _buildItemCategories(Categories categoriesData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HalamanDetailCategory(categories: categoriesData),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Image.network(categoriesData.strCategoryThumb!),
            ),
            Container(
              child: Text(
                categoriesData.strCategory!,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                  fontSize: 28.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  categoriesData.strCategoryDescription!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getListCategories(CategoriesModel categories) {
    return ListView.builder(
      itemCount: categories.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCategories(categories.categories![index]);
      },
    );
  }
}
