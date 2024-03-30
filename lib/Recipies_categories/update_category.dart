import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart'as http;

class UpdateCategory extends StatefulWidget {
  const UpdateCategory({
    super.key,
    required this.catId,
    required this.image,
    required this.catName,
  });
  final String catName;
  final String image;
  final String catId;

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  File? _selectedImage;
  TextEditingController catController = TextEditingController();
  bool _isLoading = false;
  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
  @override
  void initState() {
    catController.text=widget.catName;
    super.initState();
  }
  Future<void> updateCategory() async {
    setState(() {
      _isLoading = true; // Set loading state to true while updating
    });

    String url = "http://10.0.2.2/recepians-master/update_category.php";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add category ID, name, and image (if selected) to the request
      request.fields['cat_id'] = widget.catId;
      request.fields['cat_name'] = catController.text;
      if (_selectedImage != null) {
        var pic = await http.MultipartFile.fromPath(
          'cat_image',
          _selectedImage!.path,
        );
        request.files.add(pic);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Handle successful update
        print("Category updated successfully");
        // Add any further actions you want to take upon successful update
      } else {
        // Handle error
        print("Failed to update category: ${response.body}");
        // Add error handling based on response
      }
    } catch (e) {
      // Handle exceptions
      print("Error updating category: $e");
      // Add error handling for exceptions
    } finally {
      setState(() {
        _isLoading = false; // Set loading state back to false after update attempt
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Category"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  child: _selectedImage == null
                      ? widget.image.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                _getImageFromGallery();
                              },
                              child: Image.network(
                                  "http://10.0.2.2/recepians-master/uploads/${widget.image.toString()}"),
                            )
                          : Center(
                              child: InkWell(
                                  onTap: () {
                                    _getImageFromGallery();
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                  )),
                            )
                      :  Image.file(_selectedImage!)
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
              Container(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    updateCategory();
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text("UPDATE CATEGORY"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
