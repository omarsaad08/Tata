import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';

class UserServices {
  final supabase = Supabase.instance.client;
  static Future<Map<String, dynamic>?> fetchFullUserData() async {
    try {
      final user = await Auth.getCurrentUser();
      if (user == null) return null;

      final userId = user['id'];

      final response = await Supabase.instance.client
          .from('users')
          .select('*, doctor(*), baby(*)')
          .eq('id', userId)
          .single();
      // Merge the doctor or baby data into a single key
      print('data: $response');
      return {
        ...response,
        'extra_data': response['doctors'] ?? response['babies']
      };
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Widget> getUserImage(double width) async {
    final userId = (await Auth.getCurrentUser())!['id'];
    try {
      final String fileName = '$userId.jpg';

      // List objects in the bucket to check if the file exists
      final List<FileObject> files =
          await Supabase.instance.client.storage.from('images').list();

      bool fileExists = files.any((file) => file.name == fileName);

      if (!fileExists) {
        return Icon(
          Icons.person,
          size: 80,
          color: Colors.white,
        ); // No image found
      }
      final url = Supabase.instance.client.storage
          .from("images")
          .getPublicUrl('$userId.jpg');
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          url,
          width: width,
          height: width,
        ),
      );
    } catch (e) {
      return Icon(Icons.person);
    }
  }
}
