import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

final ImagePicker imagePicker = ImagePicker();

String imagepath = ""; // for the path of my image
String base64String = ""; // data in the form of String

Future<Uint8List?> openImage() async {
  try {
    var pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 300);
    if (pickedFile != null) {
      imagepath = pickedFile.path;

      //now convert it into a file and then numbers or bits

      File imagefile = File(imagepath);

      //now converting into numbers
      Uint8List imagebytes = await imagefile.readAsBytes();

      //now convert it into string
      base64String = base64.encode(imagebytes);

      return imagebytes;
      //now we can save it into database
    } else {
      return null;
    }
  } catch (err) {
    print('No image is selected');
    return null;
  }
}
