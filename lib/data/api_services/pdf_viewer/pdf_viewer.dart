import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiProvider {
  static Future<File> loadNetwork(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      return _storeFile(url, bytes);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    try {
      final fileName = basename(url);
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$fileName");
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception(e);
    }
  }
}
