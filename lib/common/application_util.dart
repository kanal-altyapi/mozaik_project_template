import 'package:mozaik_common/models/application_info.dart';
import 'package:mozaik_common/utilities/application_utilities.dart';

mixin ApplicationUtil {
  static   ApplicationInfo? _applicationInfo;
  static ApplicationInfo get applicationInfo {
    _applicationInfo ??= ApplicationUtilities.getApplicationInfo();
    return _applicationInfo!;
  }
}
