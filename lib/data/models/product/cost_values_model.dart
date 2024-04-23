class CostValuesModel {
  int category;
  double totalPrice;
  double totalPriceWasBought;

  CostValuesModel({
    required this.category,
    required this.totalPrice,
    required this.totalPriceWasBought,
  });

  factory CostValuesModel.fromJson(Map<String, dynamic> json) {
    return CostValuesModel(
      category: json['category'],
      totalPrice: json['totalPrice'],
      totalPriceWasBought: json['totalPriceWasBought'],
    );
  }
}
