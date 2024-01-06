class Product {
  final String? id;
  final String name;
  bool wasBought = false;
  final double price;
  final String? url;
  final String? image;

  Product(
      {required this.name,
      required this.wasBought,
      required this.price,
      this.id,
      this.image,
      this.url});

  void toggleWasBought() {
    wasBought = !wasBought;
  }
}
