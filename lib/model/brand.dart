class Brand {
  final int? id;
  final String brandName;
  final String brandCity;

  Brand({
    this.id,
    required this.brandName,
    required this.brandCity,
  });

  @override
  String toString() {
    return '{id: $id, brandName: $brandName, brandCity: $brandCity}\n';
  }
}
