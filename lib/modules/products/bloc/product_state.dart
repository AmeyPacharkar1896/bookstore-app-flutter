part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductStateInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductStateLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductStateSingleLoaded extends ProductState {
  final ProductModel product;

  const ProductStateSingleLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductStateError extends ProductState {
  final String message;

  const ProductStateError({required this.message});

  @override
  List<Object> get props => [message];
}
