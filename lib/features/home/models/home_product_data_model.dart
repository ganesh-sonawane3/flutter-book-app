class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String moreInfo;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.moreInfo});

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price'],
        imageUrl: map['imageUrl'],
        moreInfo: map['moreInfo']);
  }
}
