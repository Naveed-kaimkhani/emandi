class LedgerModel {
  final String name;
  final double amount; // Assuming amount is a double
  // Add other fields here

  LedgerModel({
    required this.name,
    required this.amount,
    // Add other fields here
  });

  // Implement the copyWith method
  LedgerModel copyWith({
    String? name,
    double? amount,
    // Add other fields here
  }) {
    return LedgerModel(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      // Add other fields here
    );
  }

  // Convert LedgerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      // Add other fields here
    };
  }

  // Create LedgerModel from JSON
  factory LedgerModel.fromJson(Map<String, dynamic> json) {
    return LedgerModel(
      name: json['name'],
      amount: json['amount'],
      // Add other fields here
    );
  }
}
