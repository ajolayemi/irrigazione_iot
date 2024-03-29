import 'package:flutter_riverpod/flutter_riverpod.dart';

final showPasswordProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final showConfirmPasswordProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
