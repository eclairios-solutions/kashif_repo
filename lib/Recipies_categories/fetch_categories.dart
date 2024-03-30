import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recepians/Recipies_categories/model/category_model.dart';
import 'package:recepians/Recipies_categories/update_category.dart';

class ViewAllCategories extends StatefulWidget {
  const ViewAllCategories({Key? key});

  @override
  State<ViewAllCategories> createState() => _ViewAllCategoriesState();
}

class _ViewAllCategoriesState extends State<ViewAllCategories> {

  late Future<List<CategoryModel>> categoriesData;
  Future<List<CategoryModel>> fetchAllCategories() async {
    print("************");
    var response = await http.get(Uri.parse('http://10.0.2.2/recepians-master/viewAll_category.php'));
    var items = jsonDecode(response.body);
    print(response.body);
    List<CategoryModel> categories = items.map<CategoryModel>((json) {
      return CategoryModel.fromJson(json);
    }).toList();
    return categories;
  }



  @override
  void initState() {
    // TODO: implement initState
    categoriesData = fetchAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: categoriesData,
        builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>
                            UpdateCategory(
                              image:snapshot.data![index].catImage.toString(),
                              catName:snapshot.data![index].catName.toString(),
                              catId:snapshot.data![index].catId.toString(),

                            )));
                      },
                      // style: ListTileStyle.,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(

                            'http://10.0.2.2/recepians-master/uploads/${snapshot.data![index].catImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(snapshot.data![index].catName.toString()),
                      trailing: Text(snapshot.data![index].catId.toString()),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
