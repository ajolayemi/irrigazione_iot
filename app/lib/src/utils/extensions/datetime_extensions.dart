extension NullableDateTimeExtensions on DateTime? {
  Duration get toDuration => Duration(
      milliseconds: this?.millisecond ?? 0,
      seconds: this?.second ?? 0,
      minutes: this?.minute ?? 0,
      hours: this?.hour ?? 0);

  String get toDurationString {
    final Duration duration =
        this == null ? Duration.zero : DateTime.now().difference(this!);
    final days = duration.inDays;
    final hours = duration.inHours;
    final finalHours = hours - days * 24;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final base = '${finalHours.toString().padLeft(2, '0')}h:${minutes.toString().padLeft(2, '0')}m:${seconds.toString().padLeft(2, '0')}s';
    return days > 0
        ? '${days.toString().padLeft(1, '0')}g:$base'
        : base;
  }
}
