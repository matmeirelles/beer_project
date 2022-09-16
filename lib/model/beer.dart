// ignore_for_file: public_member_api_docs, sort_constructors_first
class Beer {
  final int? id;
  final String beerName;
  final String beerBrand;

  const Beer({
    this.id,
    required this.beerName,
    required this.beerBrand,
  });

  @override
  bool operator ==(covariant Beer other) {
    if (identical(this, other)) return true;

    return other.beerName == beerName && other.beerBrand == beerBrand;
  }

  @override
  int get hashCode => id.hashCode ^ beerName.hashCode ^ beerBrand.hashCode;

  @override
  String toString() =>
      'Beer(id: $id, beerName: $beerName, beerBrand: $beerBrand)';
}
