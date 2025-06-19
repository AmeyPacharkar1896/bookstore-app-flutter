class OrderItemModel {
  final String id;
  final int quantity;
  final double price;
  final Map<String, dynamic> product;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      product: json['products'] ?? {},
    );
  }

  String get productType => product['product_type'] ?? 'unknown';
}
