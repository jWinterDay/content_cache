import 'dart:developer';

class ServiceCacheData {
  ServiceCacheData({
    required this.content,
    required this.ttl,
    required this.date,
  }) {
    try {
      fmtDateTime = DateTime.parse(date);
    } on Object catch (err) {
      log('ServiceCacheData. date parse err: $err');
    }
  }

  factory ServiceCacheData.fromJson(Map<String, dynamic> data) {
    return ServiceCacheData(
      content: data['content'],
      ttl: data['ttl'],
      date: data['date'],
    );
  }

  final String content;
  final int ttl;
  final String date;

  DateTime? fmtDateTime;

  @override
  String toString() {
    return 'date: $date\nttl: $ttl\ncontent: $content';
  }

  int get remainTtl {
    final DateTime now = DateTime.now();

    // final  bool isExpired = fmtDateTime?.add(Duration(seconds: ttl)).isBefore(now) ?? true;

    final Duration? diff = fmtDateTime?.difference(now);
    final int diffInSec = (diff?.inSeconds ?? 0).abs();

    return ttl - diffInSec;
  }

  //  final bool isExpired = info.date.add(info.ttl).isBefore(now);
}
