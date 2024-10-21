class ItemModel {
  String name;
  String selectedItem;
  String selectedContainer;
  int itemCount;
  double rent;
  String? percentage;
  int? portrages;
  int? itemRates;

  ItemModel({
    required this.name,
    required this.selectedItem,
    required this.selectedContainer,
    required this.itemCount,
    required this.rent,
    this.percentage,
    this.portrages,
    this.itemRates,
  });

  // Convert a ItemModel into a Map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'selectedItem': selectedItem,
      'selectedContainer': selectedContainer,
      'itemCount': itemCount,
      'rent': rent,
      'percentage':
          percentage ?? "", // Default to empty string if percentage is null
      'portrages': portrages ?? 0,
      'itemRates': itemRates ?? 0,
    };
  }

  // Convert a Map into a ItemModel.
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'],
      selectedItem: json['selectedItem'],
      selectedContainer: json['selectedContainer'],
      itemCount: json['itemCount'],
      rent: json['rent'].toDouble(), // Convert rent to double
      percentage: json['percentage'], // Assign percentage directly
      portrages: json['portrages'], // Assign portrages directly
      itemRates: json['itemRates'], // Assign itemRates directly
    );
  }
}
