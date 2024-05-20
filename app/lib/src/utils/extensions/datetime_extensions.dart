extension NullableDateTimeExtensions on DateTime? {
  Duration get toDuration => Duration(
      milliseconds: this?.millisecond ?? 0,
      seconds: this?.second ?? 0,
      minutes: this?.minute ?? 0,
      hours: this?.hour ?? 0);

  String get toDurationString {
    final Duration duration =
        this == null ? Duration.zero : DateTime.now().difference(this!);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}h:${minutes.toString().padLeft(2, '0')}m:${seconds.toString().padLeft(2, '0')}s';
  }
}
