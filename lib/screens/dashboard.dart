import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/beer_image.jpeg'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _FeatureItem(
                  name: 'Cervejas',
                  icon: Icons.sports_bar,
                  onClick: () => _goToPage(context, '/beerList'),
                ),
                _FeatureItem(
                  name: 'Marcas',
                  icon: Icons.home_filled,
                  onClick: () => _goToPage(context, '/brandList'),
                ),
                _FeatureItem(
                  name: 'Atualização de estoque',
                  icon: Icons.description,
                  onClick: () => _goToPage(context, '/stockUpdateList'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToPage(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData? icon;
  final Function? onClick;

  const _FeatureItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onClick,
  })  : assert(icon != null, 'Icon não pode ser null'),
        assert(onClick != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick!();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
