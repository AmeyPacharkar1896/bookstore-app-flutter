part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartEventAdd extends CartEvent {
  final ProductModel product;
  const CartEventAdd({required this.product});

  @override
  List<Object> get props => [product];
}

class CartEventRemove extends CartEvent {
  final String productId;
  const CartEventRemove({required this.productId});

  @override
  List<Object> get props => [productId];
}

class CartEventUpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;
  const CartEventUpdateQuantity({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, quantity];
}

class CartEventClear extends CartEvent {}

class CartEventCheckout extends CartEvent {}
