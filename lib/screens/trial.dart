import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";

class TrialScreen extends StatefulWidget {
  const TrialScreen({Key? key}) : super(key: key);

  @override
  State<TrialScreen> createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
  File? _image;
  pickImage(ImageSource source) async {
    // Pick an image
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      File? img = File(image.path);
      // now crop..
      img = await cropImage(img);
      setState(() {
        _image = img;
      });
    } catch (e) {
      print("Error in picking image => $e"); // TODO: handle it
    }
  }

  Future<File?> cropImage(File image) async {
    CroppedFile? croppedFile;

    croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              context: context,
              builder: (context) {
                return Container(
                  height: 140.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera, size: 30.0),
                        title: const Text(
                          "Camera",
                          // style: getMediumTextStyle(),
                        ),
                        onTap: () {
                          pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text("Gallery"),
                        onTap: () {
                          pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        child: Container(
          height: 250.0,
          width: 250.0,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child:
                _image == null ? null : Image.file(_image!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
