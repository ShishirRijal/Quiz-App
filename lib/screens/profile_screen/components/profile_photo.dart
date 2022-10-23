import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";
import 'package:quiz_app/services/db_services.dart';

import '../../../services/resources/style_manger.dart';
import '../../../widgets/placeholder_image.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto(this.imgUrl, {Key? key}) : super(key: key);
  final String? imgUrl;
  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  bool isUploaded = false;
  File? _image;
  late String imgName;

  pickImage(ImageSource source) async {
    // Pick an image
    try {
      var image = await ImagePicker().pickImage(source: source);

      if (image == null) {
        return;
      }
      imgName = image.name;
      File? img = File(image.path);
      // now crop..
      img = await cropImage(img);

      setState(() {
        isUploaded = true;
        _image = img;
      });
      await uploadFile();
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

  Future uploadFile() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      if (_image == null) return;
      final path = 'images/$userId/$imgName';

      // final file = _image!.path;
      final ref = FirebaseStorage.instance.ref().child(path);
      final snapshot = await ref.putFile(_image!).whenComplete(() => null);
      final imgUrl = await snapshot.ref.getDownloadURL();

      DatabaseService().updatePicture(imgUrl);
    } catch (e) {
      print("Error in uploading image => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            context: context,
            builder: (context) {
              return SizedBox(
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
                    const Divider(
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
        decoration: const BoxDecoration(
            color: ColorManager.primary, shape: BoxShape.circle),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: isUploaded
              ? Image.file(_image!, fit: BoxFit.cover)
              : widget.imgUrl == ""
                  ? placeholderImage()
                  : Image.network(widget.imgUrl!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
