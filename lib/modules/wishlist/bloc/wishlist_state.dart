// wishlist_state.dart
part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistStateInitial extends WishlistState {}

class WishlistStateLoading extends WishlistState {}

class WishlistStateLoaded extends WishlistState {
  final List<ProductModel> products;

  const WishlistStateLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class WishlistStateError extends WishlistState {
  final String error;

  const WishlistStateError({required this.error});

  @override
  List<Object?> get props => [error];
}
