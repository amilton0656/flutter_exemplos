import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pessoas/widgets/custom_pick_image.dart' as open;

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  final ImagePicker imagePicker = ImagePicker();

  String imagepath = ""; // for the path of my image
  String base64String = ""; // data in the form of String

  pegaImagem() async {
    // final String _image = await open.openImage();
    // setState(() {
    //   base64String = _image;
    // });
  }

  // a funtcion for image encoding and decoding
  openImage() async {
    try {
      var pickedFile = await imagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 300);
      if (pickedFile != null) {
        setState(() {
          imagepath = pickedFile.path;
        });
        print('>>>>>imagepath $imagepath');

        //now convert it into a file and then numbers or bits

        File imagefile = File(imagepath);

        //now converting into numbers
        Uint8List imagebytes = await imagefile.readAsBytes();
        // print(imagebytes);
        print('--------------------');

        //now convert it into string
        base64String = base64.encode(imagebytes);
        print('XX${base64String}XX');
        //now we can save it into database
      } else {
        print('No image is selected');
      }
    } catch (err) {
      print('No image is selected');
    }
  }

  Widget showImage(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: MemoryImage(base64Decode(base64String),),),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Foto 64'),
          centerTitle: true,
        ),
        body: SizedBox(
            width: double.infinity,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  imagepath != ""
                      ? Image.file(File(imagepath))
                      : Container(
                          child: const Text('No image selected'),
                        ),
                  ElevatedButton(
                      onPressed: () => pegaImagem(),
                      child: const Text('Selecet Image')),
                  const Text('Decoded image'),
                  base64String != ""
                      ? showImage(context)
                      : Container(
                          child: const Text('No image selected'),
                        ),
                ],
              ),
            )));
  }
}
