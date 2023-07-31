import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SettingParams {
  int version;
  bool gapLess;
  int errorCorrectionLevel;
  QrDataModuleStyle? dataModuleStyle;
  SettingParams(
      {this.version = QrVersions.auto,
      this.gapLess = true,
      this.errorCorrectionLevel = QrErrorCorrectLevel.L,
      this.dataModuleStyle});

  Map toMap() {
    Map map = {};
    map['version'] = version;
    map['gapLess'] = gapLess;
    map['errorCorrectionLevel'] = errorCorrectionLevel;
    if (dataModuleStyle != null) {
      map['dataModuleStyle'] = {
        'color': dataModuleStyle?.color?.value,
        'dataModuleShape': stringifyQrDataModuleShape(dataModuleStyle?.dataModuleShape)
      };
    }
    return map;
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static QrDataModuleShape? parseDataModuleShape(String shape) {
    if (shape == 'circle') {
      return QrDataModuleShape.circle;
    } else if (shape == '') {
      return QrDataModuleShape.square;
    } else {
      return null;
    }
  }

  static String? stringifyQrDataModuleShape(QrDataModuleShape? dataModuleShape) {
    if (dataModuleShape == QrDataModuleShape.circle) {
      return 'circle';
    } else if (dataModuleShape == QrDataModuleShape.square) {
      return 'square';
    }
    return null;
  }

  static QrDataModuleStyle? parseDataModuleStyle(Map? map) {
    if (map != null) {
      return QrDataModuleStyle(
          color: Color(map['color'] as int), dataModuleShape: parseDataModuleShape(map['dataModuleShape']));
    }
    return null;
  }

  factory SettingParams.fromJson(String json) {
    Map map = jsonDecode(json);
    return SettingParams(
        version: map['version'],
        gapLess: map['gapLess'],
        errorCorrectionLevel: map['errorCorrectionLevel'],
        dataModuleStyle: parseDataModuleStyle(map['dataModuleStyle']));
  }
}
