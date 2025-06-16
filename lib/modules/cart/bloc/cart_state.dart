part of 'cart_bloc.dart';

class CartState {
  final List<CartItemModel> items;

  CartState({required this.items});

  /// Total price of all items
  double get total => items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Total quantity of all items (for cart badge)
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({List<CartItemModel>? items}) {
    return CartState(items: items ?? this.items);
  }

  factory CartState.fromJson(Map<String, dynamic> json) {
    return CartState(
      items:
          (json['items'] as List<dynamic>)
              .map(
                (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((item) => item.toJson()).toList()};
  }
}
