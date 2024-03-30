import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ViewRecipes extends StatefulWidget {
  const ViewRecipes({super.key});

  @override
  State<ViewRecipes> createState() => _ViewRecipesState();
}

class _ViewRecipesState extends State<ViewRecipes> {

  List recipes=[];
  Future<void> viewAllRecipes()async{
    print("****************");
    String url="http://10.0.2.2/cat_recipe/view_recipes.php";
    try{
      var res= await http.get(Uri.parse(url));
      setState(() {
        recipes=jsonDecode(res.body);
      });
      print(res.body.toString());

    }catch(e){
      print(e.toString());

    }
  }
  @override
  void initState() {
   viewAllRecipes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("View Recipes"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
      
      
        ),
        body: ListView.builder(
          itemCount: recipes.length,

            itemBuilder: (context,index){
            final recipeData=recipes[index];
              return   Padding(
                padding:  const EdgeInsets.all(8.0),
                child:  Card(
                  child: ListTile(
                    leading:  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.redAccent,
                      backgroundImage: NetworkImage("http://10.0.2.2/cat_recipe/${recipeData['recipe_image']}"),
                    ),
                    title: Text("Category :${recipeData['cat_name']}"),
                    subtitle:  Text("Recipes:  ${recipeData['recipe_name']}"),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
