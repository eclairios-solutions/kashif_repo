import 'package:flutter/material.dart';
import 'package:recepians/Recipies_categories/add_cat.dart';
import 'package:recepians/add_recipies.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Main Screen"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddCategory()));
                    },
                    child: Container(
                      height: 160,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),

                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5,),
                          Text("Add Categories",style: TextStyle(
                              fontSize: 16,color: Colors.white,
                          fontWeight: FontWeight.w700
                          ),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddRecipes()));
                    },
                    child: Container(
                      height: 160,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),

                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5,),
                          Text("Add Recipes",style: TextStyle(
                              fontSize: 16,color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),

      ),
    );
  }
}
