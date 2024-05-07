import 'package:supabase_flutter/supabase_flutter.dart';

extension SessionExtensions on Session? {
  bool get isValid => this != null;
}
