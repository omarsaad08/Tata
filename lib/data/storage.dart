import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final storage = FlutterSecureStorage();
  static Future<void> saveIdAndType(String id, String type) async {
    await storage.write(key: 'id', value: id);
    await storage.write(key: 'type', value: type);
  }

  static Future<Map> getIdAndType() async {
    return {
      "id": await storage.read(key: 'id'),
      "type": await storage.read(key: 'type'),
    };
  }

  static Future<void> save(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> get(String key) async {
    final value = await storage.read(key: key);
    return value;
  }

  static Future<void> deleteIdAndType() async {
    await storage.delete(key: 'id');
    await storage.delete(key: 'type');
  }
}
