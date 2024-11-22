import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> uploadImageWithDio(File imageFile) async {
    final cloudName = "starshop"; // Replace with your Cloudinary cloud name
    final uploadPreset = "products"; // Replace with your upload preset
    final uploadUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    try {
      final dio = Dio();

      // Prepare form data
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
        "upload_preset": uploadPreset,
      });

      // Send POST request
      final response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        final imageUrl = response.data["secure_url"];
        return imageUrl; // Return the image URL
      } else {
        print("Error uploading image: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text("No image selected")
                : Image.file(_image!, height: 200),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Select Image"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                if (_image != null) {
                  final imageUrl = await uploadImageWithDio(_image!);
                  if (imageUrl != null) {
                    print("Uploaded Image URL: $imageUrl");
                    // Display the uploaded image URL or use it in your app
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text("Image Uploaded Successfully!\n\n$imageUrl"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    print("Image upload failed");
                  }
                } else {
                  print("No image selected");
                }
              },
              child: Text("Upload to Cloudinary"),
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: Text('favorite page'),
      // ),
    );
  }
}
