import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:tata/data/storage.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to upload the image using Dio
  Future<void> _uploadImage() async {
    if (_image == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Configure Dio
      Dio dio = Dio();

      // Create a FormData object with the image file
      String fileName = _image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(_image!.path, filename: fileName),
      });
      final id = await Storage.get('id');
      final type = await Storage.get('type');
      // Send a POST request
      Response response = await dio.put(
        'http://192.168.1.219:3000/$type/image/$id', // Replace with your API URL
        data: formData,
      );

      // Handle the response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم تغيير الصورة بنجاح')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لم يتم تغيير الصورة')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("تغيير صورة الحساب", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null ? Image.file(_image!) : Text('No image selected'),
            SizedBox(height: 20),
            mainElevatedButton(
              'اختيار الصور',
              _pickImage,
            ),
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : mainElevatedButton(
                    'حفظ',
                    _uploadImage,
                  ),
          ],
        ),
      ),
    );
  }
}
