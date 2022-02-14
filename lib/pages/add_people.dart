import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_data/controllers/people_controller.dart';
import 'package:flutter_local_data/models/people_model.dart';
import 'package:flutter_local_data/pages/show_people.dart';
import 'package:flutter_local_data/widgets/app_styles.dart';
import 'package:image_picker/image_picker.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({Key? key}) : super(key: key);

  @override
  State<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  final name = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  String? _imageString;
  List<XFile>? _imageFileList;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();
  void _onImagePressed(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: double.maxFinite,
        maxHeight: double.maxFinite,
        imageQuality: 100,
      );
      setState(() {
        _imageFile = pickedFile;
        List<int> imageBytes = File(pickedFile!.path).readAsBytesSync();
        _imageString = base64Encode(imageBytes);
      });
    } catch (e) {
      print('Image Error : $e');
    }
  }

  _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _onImagePressed(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _onImagePressed(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector _buildImage(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Container(
        height: 130.0,
        width: 130.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 221, 216, 216),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
            width: 3.0,
          ),
          image: _imageFileList != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: kIsWeb
                      ? NetworkImage(_imageFileList!.first.path)
                      : Image.file(File(_imageFileList!.first.path)).image,
                )
              : null,
        ),
        child: _imageFileList != null ? null : const Icon(Icons.camera_alt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add People'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage(context),
                const SizedBox(height: 20.0),
                TextField(
                  style: AppStyle.textSize,
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  style: AppStyle.textSize,
                  controller: gender,
                  decoration: const InputDecoration(
                    hintText: 'Gender',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  style: AppStyle.textSize,
                  controller: address,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    //create people object
                    var people = PeopleModel(
                      id: 0,
                      name: name.text,
                      gender: gender.text,
                      address: address.text,
                      photo: _imageString ?? '',
                    );
                    //insert people to database
                    await PeopleController().insertPeople(people);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ShowPeople()),
                    );
                    print('Insert Success');
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
