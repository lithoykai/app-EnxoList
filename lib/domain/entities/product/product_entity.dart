enum Room { cozinha, sala, quarto, banheiro, eletro, lavanderia, reforma }

class ProductEntity {
  final String? id;
  final String name;
  bool wasBought = false;
  final double price;
  int category;
  String? urlLink;
  String? image;

  ProductEntity(
      {required this.name,
      required this.wasBought,
      required this.price,
      required this.category,
      this.id,
      this.image,
      this.urlLink});

  void toggleWasBought() {
    wasBought = !wasBought;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wasBought': wasBought,
      'price': price,
      'category': category,
      'id': id,
      'image': image,
      'urlLink': urlLink,
    };
  }
}
