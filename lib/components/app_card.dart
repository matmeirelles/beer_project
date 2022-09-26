import 'package:beers_project/components/todo_snackbar.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Function? onClick;
  final IconData? icon;
  final String title;
  final String? subtitle;
  final double? fontSize;
  final bool canDelete;

  const AppCard({
    Key? key,
    this.onClick,
    this.icon,
    required this.title,
    this.subtitle,
    this.fontSize = 16.0,
    this.canDelete = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick!(),
        enabled: onClick != null ? true : false,
        leading: icon != null ? Icon(icon) : null,
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: Visibility(
          visible: canDelete,
          child: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(showToDoSnackbar());
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
