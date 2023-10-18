import 'package:flutter/material.dart';

class PmsSize {
  final double _physicalSizeWidth = WidgetsBinding.instance.window.physicalSize.width;
  final double _physicalSizeHeight = WidgetsBinding.instance.window.physicalSize.height;
  final double _devicePixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
  double get height => _physicalSizeHeight / _devicePixelRatio;
  double get width => _physicalSizeWidth / _devicePixelRatio;
  EdgeInsetsGeometry get cardPadding => EdgeInsets.all(width / 25);
}
