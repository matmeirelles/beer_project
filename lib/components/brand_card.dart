import 'package:beers_project/components/todo_snackbar.dart';
import 'package:flutter/material.dart';

import '../model/brand.dart';

class BrandCard extends StatelessWidget {
  final Brand brand;

  const BrandCard({
    Key? key,
    required this.brand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(showToDoSnackbar());
        },
        leading: const Icon(Icons.home_filled),
        title: Text(brand.brandName),
        subtitle: Text(brand.brandCity),
        trailing: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(showToDoSnackbar());
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
