import 'package:flutter/material.dart';
import 'package:mozaik_localization/mozaik_localization.dart';
import 'localization_util.dart' as localization;

String? translate(BuildContext context, String key) {
  String? value = MozLocalizations.of(context).translate(key);

  return value; //?? key;
}

String translateAndInterpolate(BuildContext context, String key, List<String> values) {
  return MozLocalizations.of(context).translateAndInterpolate(key, values);
}

String getVersionText(BuildContext context) {
  String version = localization.translate(context, 'Version')!;

  return version;
}
