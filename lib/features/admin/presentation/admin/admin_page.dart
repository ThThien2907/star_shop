import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/product/models/product_model.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_products_by_category_use_case.dart';
import 'package:star_shop/features/domain/product/use_cases/get_top_selling_use_case.dart';
import 'package:star_shop/service_locator.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  String a = '';

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

    String generateRandomString(int length) {
      const characters =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();

      return List.generate(
              length, (index) => characters[random.nextInt(characters.length)])
          .join();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('title'),
            TextField(
              controller: controller1,
            ),
            Text('des'),
            TextField(
              controller: controller,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
            ),
            Text('cate'),
            TextField(
              controller: controller2,
            ),
            Text('price'),
            TextField(
              controller: controller3,
            ),
            Text('old price'),
            TextField(
              controller: controller4,
            ),
            ElevatedButton(
              onPressed: () async {
                // final randomString =
                // generateRandomString(20); // Change length as needed
                // //
                // // print(randomString);
                // a = controller.text.replaceAll('\n', '\\n');
                //
                // var pro = ProductModel(
                //   productID: randomString,
                //   title: controller1.text.trim(),
                //   description: a,
                //   categoryID: controller2.text.trim(),
                //   price: int.parse(controller3.text.trim()),
                //   oldPrice: int.parse(controller4.text.trim()),
                //   images: [],
                //   quantityInStock: 10,
                //   salesNumber: 0,
                //   rating: 5.0,
                //   reviews: [],
                // );
                // var res = await sl<AuthFirebaseService>().setPro(pro);
                // print(a);

                var res = await GetProductsByCategoryUseCase().call(params: 'category00');
                res.fold(
                  (ifLeft) {
                    print(ifLeft);
                  },
                  (ifRight) {
                    List<ProductEntity> products = ifRight;
                    print(products.length);
                  },
                );
              },
              child: Text('asd'),
            ),

            Center(
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
          ],
        ),
      ),
    );
  }
}
