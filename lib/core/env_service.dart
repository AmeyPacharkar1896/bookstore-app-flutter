import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  // Make init a proper async function
  static Future<void> init() async {
    try {
      await dotenv.load(fileName: ".env");
      log("✅ .env loaded successfully");
    } catch (e) {
      log("❌ Error loading .env file: $e");
    }
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
