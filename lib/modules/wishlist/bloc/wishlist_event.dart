part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class WishlistEventToggle extends WishlistEvent {
  final String productId;

  const WishlistEventToggle({required this.productId});

  @override
  List<Object> get props => [productId];
}

class WishlistEventLoad extends WishlistEvent {}

class WishlistEventSearch extends WishlistEvent {
  final String query;

  const WishlistEventSearch({required this.query});

  @override
  List<Object> get props => [query];
}
