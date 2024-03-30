import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:recepians/view_recipes.dart';
class AddRecipes extends StatefulWidget {
  const AddRecipes({super.key});

  @override
  State<AddRecipes> createState() => _AddRecipesState();
}

class _AddRecipesState extends State<AddRecipes> {
  TextEditingController recipeController=TextEditingController();
  TextEditingController categoryController=TextEditingController();
  File? _selectedImage;
  String? imageName;
  String? imageData;


  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        imageName=pickedImage.path.split('/').last;
        imageData=base64Encode(_selectedImage!.readAsBytesSync());
      });
    }
  }
  Future<void> uploadRecipes()async{
    String uri="http://10.0.2.2/cat_recipe/upload_recipe.php";
    var res=await http.post(Uri.parse(uri),
    body: {
      "rname":recipeController.text,
      "cname":categoryController.text,
      "rimagename":imageName,
      "data":imageData,

    },

    );
    var response=jsonDecode(res.body);
    if(response['success']=='true'){
      print("recipe uploaded successfully");

    }else{
      print("something went wrong");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipes"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,


      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
        child: SingleChildScrollView(
          child: Column(
          
            children: [
              Container(
                width: 300,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
          
                ),
                child: Center(
                  child: IconButton(onPressed: (){
                    _getImageFromGallery();
                  },
                  icon: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.cover):const Icon(CupertinoIcons.camera_circle_fill,size: 40,),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter Category Name"),
          
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: recipeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter Recipe Name "),
          
                ),
              ),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.all(12),
                width: 200,
          
                color: Colors.black26,
                child: ElevatedButton(
                  onPressed: (){
                    uploadRecipes();
                  },
                  child: const Text("Upload"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                width: 200,
          
                color: Colors.black26,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_)=>const ViewRecipes()));
                  },
                  child: const Text("View All Recipes"),
                ),
              ),
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}
