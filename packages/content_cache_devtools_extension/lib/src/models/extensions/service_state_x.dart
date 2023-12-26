import 'package:content_cache_devtools_extension/src/index.dart';
import 'package:intl/intl.dart';

extension ServiceStateX on ServiceState {
  String? get fetchDateTimeStr {
    if (fetchDate == null) {
      return null;
    }

    return DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(fetchDate!);
  }
}
