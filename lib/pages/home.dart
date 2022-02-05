import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_upload/api/api.dart';
import 'package:image_upload/models/response_model.dart';
import 'package:image_upload/utils/app_overlay.dart';
import 'package:image_upload/utils/dialog_layout.dart';
import 'package:image_upload/utils/image_helper.dart';

class Home extends StatefulWidget {
  static const String route = '/';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              GestureDetector(
                onTap: pick,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: imageFile == null
                      ? const Text('Pick Image')
                      : Image.file(imageFile!),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                height: 50,
                minWidth: 120,
                color: Colors.blue,
                onPressed: upload,
                child: const Text(
                  'Upload',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///pick image form gallery
  pick() async {
    File? image = await ImageHelper.pickImage();
    if (image != null) {
      setState(() => imageFile = image);
    }
  }

  upload() async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image is Empty...!')),
      );
      return;
    }
    AppOverlay.show(context);
    ResponseModel resp = await API.upload(imageFile: imageFile!);
    AppOverlay.pop(context);
    AppOverlay.show(context, child: DialogLayout(msg: resp.data));
  }
}
