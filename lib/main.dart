import 'package:bookstore_app/application.dart';
import 'package:bookstore_app/core/env_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvService.init();

  await Supabase.initialize(
    url: EnvService.supabaseUrl,
    anonKey: EnvService.supabaseAnonKey,
    authOptions: FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    )
  );

  runApp(const Application());
}
