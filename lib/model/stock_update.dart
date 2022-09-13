class StockUpdate {
  final String id;
  final String beerName;
  final int beerQuantity;

  StockUpdate({
    required this.id,
    required this.beerName,
    required this.beerQuantity,
  }) : assert(beerQuantity > 0);

//Retorna um StockUpdate a partir de um elemento 'json'
  StockUpdate.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        beerName = json['contact']['name'],
        beerQuantity = json['value'].toInt();

  //Transformar um StockUpdate em um elemento 'json'
  Map<String, dynamic> toJson() => {
        'id': id,
        'value': beerQuantity,
        'contact': {
          'name': beerName,
          'accountNumber': 1000,
        }
      };

  @override
  String toString() {
    return '{beer_name: $beerName, beer_quantity: $beerQuantity}';
  }
}
