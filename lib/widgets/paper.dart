import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool disableBottomMargin;
  const Paper({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(8.0),
    this.disableBottomMargin = false
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: padding,
      margin: disableBottomMargin ? margin.copyWith(bottom: 0) : margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black12, offset: Offset(2, 2), blurRadius: 8.0)]),
      child: child,
    );
  }
}
