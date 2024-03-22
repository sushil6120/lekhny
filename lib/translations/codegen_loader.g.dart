// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "hi_text": "Good Morning, Have a good day"
};
static const Map<String,dynamic> hi = {
  "hi_text": "सुप्रभातम आपका दिन शुभ हो"
};
static const Map<String,dynamic> ur = {
  "hi_text": "صبح بخیر، آپ کا دن اچھا گزرے۔"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "hi": hi, "ur": ur};
}
