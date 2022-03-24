
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? pickedImage;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  pickImage(ImageSource imageType) async {
    print('Pick Image function call');
    final SharedPreferences prefs = await _prefs;
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        prefs.setString('file', tempImage.path);
        print('${tempImage.path}');
        pickedImage = tempImage;
        Navigator.of(context).pop();
      });

    } catch (error) {
      debugPrint(error.toString());
    }
  }

   checkPref()async{
     final SharedPreferences prefs = await _prefs;
     var file=prefs.getString('file')??'';
     if(file.isEmpty){
       print('no file');
     }else{
       print('File Location : '+file);
       File newFile=File(file);
       setState(() {
         pickedImage=newFile;
       });

     }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipOval(
                    child: pickedImage != null?Image.file(pickedImage!,
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,)
                        :Image.asset(
                      'assets/images/noimage.jpg',
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  showBottom(context);
                },
                icon: const Icon(Icons.add_a_photo_sharp),
                label: const Text('UPLOAD IMAGE')),
          )
        ],
      ),
    );
  }

  void showBottom(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) => Container(
          width: 300,
          height: 200,
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pic Image From",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                label: const Text("CAMERA"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
                label: const Text("GALLERY"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                label: const Text("CANCEL"),
              ),
            ],
          ),
        ));
  }
}
