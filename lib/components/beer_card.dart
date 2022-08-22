import 'package:beers_project/components/todo_snackbar.dart';
import 'package:flutter/material.dart';
import '../model/beer.dart';

///Abstrair classe Card para ser utilizada por Beer e Brand

class BeerCard extends StatelessWidget {
  final Beer beer;
  final Function onClick;

  const BeerCard({
    Key? key,
    required this.beer,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        leading: const Icon(Icons.sports_bar),
        title: Text(beer.beerName),
        subtitle: Text(beer.beerBrand),
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
