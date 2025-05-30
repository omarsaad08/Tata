import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/extensions/translation_extension.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/theme.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  final SupabaseClient supabase = Supabase.instance.client;
  final String bucketName = 'images'; // Your Supabase Storage bucket

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to upload image to Supabase Storage
  Future<void> _uploadImage() async {
    if (_image == null) return;

    setState(() {
      _isUploading = true;
    });

    final user = (await Auth.getCurrentUser());
    try {
      if (user == null) {
        throw Exception("User not logged in.");
      }

      // Generate a unique filename
      String fileName = '${user['id']}.jpg';

      if (kIsWeb) {
        // 🔹 Read image as bytes for Web
        XFile xfile = XFile(_image!.path);
        Uint8List fileBytes = await xfile.readAsBytes();

        // Upload binary file for web
        await supabase.storage.from(bucketName).uploadBinary(
            fileName, fileBytes,
            fileOptions: const FileOptions(upsert: true));
      } else {
        // 🔹 Upload File for Android/iOS
        await supabase.storage.from(bucketName).upload(fileName, _image!,
            fileOptions: const FileOptions(upsert: true));
      }

      // Get public URL
      final imageUrl = supabase.storage.from(bucketName).getPublicUrl(fileName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تغيير الصورة بنجاح')),
      );

      // Save the URL to your database if needed
      // await supabase.from('users').update({'profile_image': imageUrl}).eq('id', userId);

      setState(() {
        _image = null; // Clear image after upload
      });

      Navigator.pushReplacementNamed(context, "${user['role']}Home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print("error: $e");
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
        backgroundColor: clr(1),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kIsWeb
                  ? (_image != null
                      ? Image.network(
                          _image!.path,
                          width: 200,
                        )
                      : Text(context.tr("no-image-selected")))
                  : (_image != null
                      ? Image.file(
                          _image!,
                          width: 200,
                        )
                      : Text(context.tr("no-image-selected"))),
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
              SizedBox(
                height: 20,
              ),
              mainElevatedButton("تخطي", () async {
                final role = (await Auth.getCurrentUser())!['role'];
                Navigator.pushReplacementNamed(context, "${role}Home");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
