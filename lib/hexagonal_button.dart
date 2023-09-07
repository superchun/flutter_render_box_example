import 'package:flutter/cupertino.dart';
import 'package:render_box/render_hexagonal_button.dart';

class HexagonalButton extends SingleChildRenderObjectWidget {
  final Color color;
  final double clipSize;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final PointerDownEventListener onPointerDown;
  const HexagonalButton({
    Key? key,
    required Widget child,
    required this.color,
    required this.clipSize,
    required this.padding,
    required this.onTap,
    required this.onPointerDown,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderHexagonalButton(
      color: color,
      clipSize: clipSize,
      padding: padding,
      onTap: onTap,
      onPointerDown: onPointerDown,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderHexagonalButton renderObject) {
    renderObject
      ..color = color
      ..clipSize = clipSize
      ..padding = padding
      ..onTap = onTap;
  }
}
