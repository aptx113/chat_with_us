import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  MeasureSizeRenderObject(this.onChange);

  Size? oldSize;
  final OnWidgetSizeChange onChange;

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child?.size as Size;
    if (oldSize == newSize) return;
    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  const MeasureSize({Key? key, required this.onChange, required Widget child})
      : super(key: key, child: child);
  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
