import 'dart:developer';

import 'package:content_cache_devtools_extension/src/index.dart';
import 'package:intl/intl.dart';

extension ServiceCacheDataX on ServiceCacheData {
  // static final Expando<int> _remainCache = Expando<int>('ServiceCacheDataX. remain');

  DateTime? get _fmtDateTime {
    try {
      return DateTime.parse(date);
    } on Object catch (err) {
      log('ServiceCacheData. date parse err: $err');

      return null;
    }
  }

  String get fmtDateTimeStr {
    if (_fmtDateTime == null) {
      return 'null';
    }

    return DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(_fmtDateTime!);
  }

  int get remainTtl {
    // cache
    // final int? cachedResult = _remainCache[this];
    // if (cachedResult != null) {
    //   return cachedResult;
    // }

    if (_fmtDateTime == null) {
      // _remainCache[this] = 0;

      return 0;
    }
    final DateTime now = DateTime.now();

    final Duration diff = _fmtDateTime!.difference(now);
    final int diffInSec = diff.inSeconds.abs();

    final int result = ttl - diffInSec;

    // cache
    // _remainCache[this] = result;

    return result;
  }
}
