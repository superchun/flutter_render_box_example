import 'package:flutter/rendering.dart';

class RenderHexagonalButton extends RenderShiftedBox {
  RenderHexagonalButton({
    RenderBox? child,
    required Color color,
    required double clipSize,
    required EdgeInsets padding,
    required VoidCallback onTap,
  })  : _color = color,
        _clipSize = clipSize,
        _padding = padding,
        _onTap = onTap,
        super(child);

  Color _color;
  Color get color => _color;
  set color(Color color) {
    if (_color == color) return;
    _color = color;
    markNeedsPaint();
  }

  double _clipSize;
  double get clipSize => _clipSize;
  set clipSize(double size) {
    if (_clipSize == size) return;
    _clipSize = size;
    markNeedsLayout();
  }

  EdgeInsets _padding;
  EdgeInsets get padding => _padding;
  set padding(EdgeInsets padding) {
    if (_padding == padding) return;
    _padding = padding;
    markNeedsLayout();
  }

  VoidCallback _onTap;
  VoidCallback get onTap => _onTap;
  set onTap(VoidCallback onTap) {
    if (_onTap == onTap) return;
    _onTap = onTap;
    markNeedsSemanticsUpdate();
  }
}
