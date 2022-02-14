import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatefulWidget {
  final List<XFile>? imageFileList;
  const ImageWidget({Key? key, this.imageFileList}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  List<XFile>? _imageFileList;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();
  void _onImagePressed(ImageSource source, {bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          imageQuality: 100,
        );
        setState(() {
          _imageFileList = pickedFileList;
        });
      } catch (e) {
        print('Image Error : $e');
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          imageQuality: 100,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        print('Image Error : $e');
      }
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
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _onImagePressed(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _onImagePressed(ImageSource.camera);
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
      onTap: () {
        _showPicker(context);
      },
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
    return _buildImage(context);
  }
}
