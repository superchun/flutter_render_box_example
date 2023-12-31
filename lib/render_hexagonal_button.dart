import 'dart:math';

import 'package:flutter/rendering.dart';

class RenderHexagonalButton extends RenderShiftedBox {
  RenderHexagonalButton({
    RenderBox? child,
    required Color color,
    required double clipSize,
    required EdgeInsets padding,
    required VoidCallback onTap,
    required this.onPointerDown,
  })  : _color = color,
        _clipSize = clipSize,
        _padding = padding,
        _onTap = onTap,
        super(child);

  final PointerDownEventListener onPointerDown;

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

  @override
  void performLayout() {
    size = _computeSize(
        constraints: constraints,
        layoutChild: (RenderBox child, BoxConstraints constraint) {
          child.layout(constraints, parentUsesSize: true);
          return child.size;
        });
    if (child != null) {
      /// parent决定position
      final childParentData = child!.parentData! as BoxParentData;

      /// 对齐方式
      childParentData.offset = Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: (RenderBox child, BoxConstraints constraint) => child.getDryLayout(constraints),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final path = _getBorderPath(size);
    final shiftedPath = path.shift(offset);
    context.canvas.drawPath(
      shiftedPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color,
    );

    /// 绘制 child
    super.paint(context, offset);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final path = _getBorderPath(size);
    if (!path.contains(position)) {
      return false;
    }
    return super.hitTest(result, position: position);
  }

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    debugPrint('测试');
    if (event is PointerDownEvent) {
      onPointerDown(event);
    }
  }

  Size _computeSize({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    if (child != null) {
      /// 向下传递约束，向上传递尺寸

      /// 根据padding等确定约束
      final childConstraints = constraints.deflate(padding);

      /// 传递约束，确定 child 的尺寸
      final childSize = layoutChild(child!, childConstraints);
      final clipsWidth = clipSize * 2;

      /// 根据 padding、clipSize 确定具体尺寸
      final targetSize = Size(
        clipsWidth + childSize.width + padding.horizontal,
        max(40, childSize.height + padding.vertical),
      );

      /// 更精确的尺寸
      return constraints.constrain(targetSize);
    }
    return Size(clipSize * 2, 40);
  }

  Path _getBorderPath(Size size) {
    final rect = Offset.zero & size;
    return Path()
      ..moveTo(rect.centerLeft.dx, rect.centerLeft.dy)
      ..lineTo(rect.topLeft.dx + clipSize, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx - clipSize, rect.topRight.dy)
      ..lineTo(rect.centerRight.dx, rect.centerRight.dy)
      ..lineTo(rect.bottomRight.dx - clipSize, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx + clipSize, rect.bottomLeft.dy)
      ..close();
  }
}
