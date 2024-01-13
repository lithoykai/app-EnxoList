enum Room { cozinha, sala, quarto, banheiro, eletro, lavanderia, reforma }

class CategoriesEntity {
  final int id;
  final String name;
  final String urlImage;
  final Room category;

  CategoriesEntity({
    required this.id,
    required this.name,
    required this.urlImage,
    required this.category,
  });
}

class ProductEntity {
  final String? id;
  final String name;
  bool wasBought = false;
  final double price;
  int idCategory;
  String? urlLink;
  String? image;

  ProductEntity(
      {required this.name,
      required this.wasBought,
      required this.price,
      required this.idCategory,
      this.id,
      this.image,
      this.urlLink});

  void toggleWasBought() {
    wasBought = !wasBought;
  }
}
