import 'package:beers_project/screens/beers/beer_list.dart';
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
      body: LayoutBuilder(
        builder: (context, constrains) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constrains.maxHeight,
            ),
            child: Column(
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
                      FeatureItem(
                        name: 'Cervejas',
                        icon: Icons.sports_bar,
                        onClick: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const BeerList())),
                      ),
                      FeatureItem(
                        name: 'Marcas',
                        icon: Icons.home_filled,
                        onClick: () => _goToPage(
                            context: context, routeName: '/brandList'),
                      ),
                      FeatureItem(
                        name: 'Atualização de estoque',
                        icon: Icons.description,
                        onClick: () => _goToPage(
                            context: context, routeName: '/stockUpdateList'),
                      ),
                      FeatureItem(
                        name: 'Transferências',
                        icon: Icons.description,
                        onClick: () =>
                            _goToPage(context: context, routeName: '/transfer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToPage({required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }
}

class FeatureItem extends StatelessWidget {
  final String name;
  final IconData? icon;
  final Function? onClick;

  const FeatureItem({
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
