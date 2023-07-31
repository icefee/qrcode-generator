import 'package:flutter/material.dart';
import './paper.dart';

class InlineFormField extends StatelessWidget {
  const InlineFormField({
    super.key,
    required this.title,
    required this.formWidget
  });

  final String title;
  final Widget formWidget;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Paper(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      disableBottomMargin: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          formWidget
        ],
      ),
    );
  }
}
