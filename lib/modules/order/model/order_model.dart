class OrderModel {
  final String id;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      totalAmount: (map['total_amount'] as num).toDouble(),
      status: map['order_status'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
