import 'dart:io';

import 'package:dio/dio.dart';

class UploadImage {
  static Future<String?> uploadImage(
      {required File imageFile, required String uploadPreset}) async {
    String cloudName = "starshop"; // Replace with your Cloudinary cloud name
    // final uploadPreset = uploadPreset; // Replace with your upload preset
    String uploadUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

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
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
