import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_formatter.g.dart';

@riverpod
DateFormat dateFormat(Ref ref) {
  return DateFormat.yMMMd();
}

@riverpod
DateFormat dateFormatWithTime(Ref ref) {
  return DateFormat.yMMMd().add_Hm();
}
