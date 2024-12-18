import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  String text;
  Color color;

  List<Widget> children;

  bool expanded;
  dynamic onExpansionChanged;

  CustomExpansionTile({required this.text,
    this.color = Colors.black,
    required this.children, this.expanded = false, required this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // leading: const Icon(Icons.person),
      title: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: color, fontSize: 15),
      ),

      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      collapsedTextColor: Colors.white,
      collapsedIconColor: Colors.black,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      textColor: Colors.white,
      iconColor: Colors.black,
      children: children,
      initiallyExpanded: expanded,
      onExpansionChanged: onExpansionChanged,

    );
  }
}
