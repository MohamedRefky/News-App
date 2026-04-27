extension DateTimeFormatter on DateTime {
  String formatDateTime() {
    final deff = DateTime.now().difference(this);

    if (deff.inMinutes < 60) {
      return '${deff.inMinutes} minutes ago';
    } else if (deff.inHours < 24) {
      return '${deff.inHours} hours ago';
    } else {
      return '${deff.inDays} days ago';
    }
  }
}
