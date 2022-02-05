import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_upload/utils/api_const.dart';
import 'package:image_upload/models/response_model.dart';

class API {
  /// You can check this resource
  ///https://stackoverflow.com/questions/49125191/how-to-upload-images-and-file-to-a-server-in-flutter
  static Future<ResponseModel> upload({required File imageFile}) async {
    Uri url = Uri.parse(ApiConst.imageUploadURL);
    http.MultipartRequest request = http.MultipartRequest('POST', url);

    ///image multipart file from file path
    var image = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(image);

    /// ignore this headers if there is no authentication
    /*
        Map<String, String> headers = {
          "Accept": "application/json",
          "Authorization": "Bearer " + token
       };
        request.headers.addAll(headers);
     **/

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        ///check response body, convert json to dart model
        return ResponseModel(
          status: data['status'],
          data: data['data']['link'],
          success: data['success'],
        );
      } else {
        var data = jsonDecode(response.body) as Map<String, dynamic>;

        return ResponseModel(
          status: response.statusCode,
          data:
              data.containsKey('data') ? data['data']['error'] : 'upload fail!',
          success: false,
        );
      }
    } catch (e) {
      return ResponseModel(
        status: 400,
        data: 'Error -> $e',
        success: false,
      );
    }
  }
}
