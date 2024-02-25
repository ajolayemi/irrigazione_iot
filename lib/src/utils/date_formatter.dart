import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_formatter.g.dart';

@riverpod
DateFormat dateFormat(DateFormatRef ref) {
  return DateFormat.yMMMd();
}

@riverpod
DateFormat dateFormatWithTime(DateFormatWithTimeRef ref) {
  return DateFormat.yMMMd().add_Hm();
}
