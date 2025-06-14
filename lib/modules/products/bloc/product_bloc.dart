import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:bookstore_app/modules/products/service/supabase_product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductStateInitial()) {
    on<ProductEventFetchAllProducts>(_onFetchAllProducts);
    on<ProductEventFetchProductById>(_onFetchProductById);
    on<ProductEventSearch>(_onSearchProducts);
    on<ProductEventFilterByCategory>(_onFilterByCategory);
    on<ProductEventFilterByType>(_onFilterByType);
    on<ProductEventFilterByTag>(_onFilterByTag);
    on<ProductEventSortBy>(_onSortBy);
  }

  final _productService = SupabaseProductService();

  Future<void> _onFetchAllProducts(
    ProductEventFetchAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final products = await _productService.fetchAllProducts();
      emit(ProductStateLoaded(products: products));
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }

  Future<void> _onFetchProductById(
    ProductEventFetchProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final product = await _productService.fetchProductById(event.productId);
      if (product != null) {
        emit(ProductStateSingleLoaded(product: product)); // updated here
      } else {
        emit(ProductStateError(message: 'Product not found'));
      }
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    ProductEventSearch event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final results = await _productService.searchProducts(event.query);
      emit(ProductStateLoaded(products: results));
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }

  Future<void> _onFilterByCategory(
    ProductEventFilterByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final results = await _productService.fetchProductsByCategory(
        event.category,
      );
      emit(ProductStateLoaded(products: results));
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }

  Future<void> _onFilterByType(
    ProductEventFilterByType event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final results = await _productService.fetchProductByType(
        event.productType,
      );
      emit(ProductStateLoaded(products: results));
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }

  Future<void> _onFilterByTag(
    ProductEventFilterByTag event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final results = await _productService.filterByTag(event.tag);
      emit(ProductStateLoaded(products: results));
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }

  Future<void> _onSortBy(
    ProductEventSortBy event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());
    try {
      final results = await _productService.sortProducts(
        sortBy: event.sortBy,
        ascending: event.ascending,
      );
      emit(ProductStateLoaded(products: results));
    } catch (e) {
      emit(ProductStateError(message: e.toString()));
    }
  }
}
