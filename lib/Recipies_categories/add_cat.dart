import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recepians/Recipies_categories/fetch_categories.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File? _selectedImage;
  TextEditingController catController = TextEditingController();
  bool _isLoading = false;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadCategory() async {
    setState(() {
      _isLoading = true;
    });
    final uri = Uri.parse("http://10.0.2.2/recepians-master/create_category.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['cat_name'] = catController.text;
    var pic = await http.MultipartFile.fromPath('cat_image', _selectedImage!.path);
    request.files.add(pic);
    var response = await request.send();
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Category Uploaded Successfully");
      print("Category Uploaded Successfully");
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      print("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('Add Category'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const ViewAllCategories()));
          },
              icon: const Icon(Icons.view_comfy_alt))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _getImageFromGallery();
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.cover)
                      : const Center(child: Icon(Icons.camera_alt)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black26),
                ),
                child: TextField(
                  controller: catController,
                  decoration: const InputDecoration(
                    hintText: "Enter A Category Name",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  uploadCategory();
                },
                child: _isLoading
                    ? CircularProgressIndicator()
                    : const Text("Add Category"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
