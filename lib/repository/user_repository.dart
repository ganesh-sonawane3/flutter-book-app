import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserRepository {
  static const String _fileName = "users.json";

  // Get file path asynchronously
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_fileName');

    // Ensure the file exists before using it
    if (!await file.exists()) {
      await file.create(); // Create file if it doesn't exist
      await file.writeAsString(jsonEncode([])); // Initialize with empty array
    }

    return file;
  }

  // Load users from file
  Future<List<Map<String, dynamic>>> loadUsers() async {
    try {
      final file = await _getFile();
      final content = await file.readAsString();

      if (content.isEmpty) return []; // Return empty list if file is empty

      return List<Map<String, dynamic>>.from(json.decode(content));
    } catch (e) {
      print("Error loading users: $e"); // Debugging error
      return [];
    }
  }

  // Save users to file
  Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    try {
      final file = await _getFile();
      await file.writeAsString(jsonEncode(users));
    } catch (e) {
      print("Error saving users: $e"); // Debugging error
    }
  }
}
