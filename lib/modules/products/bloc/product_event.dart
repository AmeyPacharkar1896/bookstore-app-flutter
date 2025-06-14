part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductEventFetchAllProducts extends ProductEvent {}

class ProductEventFetchProductById extends ProductEvent {
  final String productId;

  const ProductEventFetchProductById({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ProductEventSearch extends ProductEvent {
  final String query;

  const ProductEventSearch({required this.query});

  @override
  List<Object> get props => [query];
}

class ProductEventFilterByCategory extends ProductEvent {
  final String category;

  const ProductEventFilterByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class ProductEventFilterByType extends ProductEvent {
  final String productType;

  const ProductEventFilterByType({required this.productType});

  @override
  List<Object> get props => [productType];
}

class ProductEventSortBy extends ProductEvent {
  final String sortBy;
  final bool ascending;

  const ProductEventSortBy({required this.sortBy, this.ascending = true});

  @override
  List<Object> get props => [sortBy, ascending];
}

class ProductEventFilterByTag extends ProductEvent {
  final String tag;

  const ProductEventFilterByTag({required this.tag});

  @override
  List<Object> get props => [tag];
}
