class PantryItem {
  final String id;
  final String name;
  final int quantity;
  final DateTime expireDate;

  PantryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.expireDate,
  });

  factory PantryItem.fromMap(String id, Map<String, dynamic> map) {
    return PantryItem(
      id: id,
      name: map['name'],
      quantity: map['quantity'],
      expireDate: DateTime.parse(map['expireDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'expireDate': expireDate.toIso8601String(),
    };
  }
}
