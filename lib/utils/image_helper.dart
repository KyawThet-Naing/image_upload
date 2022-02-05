import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
}
