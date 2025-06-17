import 'dart:async';

import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:bookstore_app/modules/wishlist/service/wishlist_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final _wishListService = WishlistService();
  final Set<String> _wishlistIds = {};

  WishlistBloc() : super(WishlistStateInitial()) {
    on<WishlistEventLoad>(_onWishlistEventLoad);
    on<WishlistEventToggle>(_onWishlistEventToggle);
    on<WishlistEventSearch>(_onWishlistEventSearch);
  }

  FutureOr<void> _onWishlistEventLoad(
    WishlistEventLoad event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistStateLoading());
    try {
      final wishedProducts = await _wishListService.fetchWishlistProducts();
      _wishlistIds
        ..clear()
        ..addAll(wishedProducts.map((p) => p.id));
      emit(WishlistStateLoaded(products: wishedProducts));
    } catch (e) {
      emit(WishlistStateError(error: e.toString()));
    }
  }

  FutureOr<void> _onWishlistEventToggle(
    WishlistEventToggle event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      final isWished = _wishlistIds.contains(event.productId);

      if (isWished) {
        await _wishListService.removeFromWishlist(event.productId);
        _wishlistIds.remove(event.productId);
      } else {
        await _wishListService.addToWishlist(event.productId);
        _wishlistIds.add(event.productId);
      }

      final wishedProducts = await _wishListService.fetchWishlistProducts();
      _wishlistIds
        ..clear()
        ..addAll(wishedProducts.map((p) => p.id));
      emit(WishlistStateLoaded(products: wishedProducts));
    } catch (e) {
      emit(WishlistStateError(error: e.toString()));
    }
  }

  FutureOr<void> _onWishlistEventSearch(
    WishlistEventSearch event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistStateLoading());
    try {
      final searchedProducts = await _wishListService.searchWishlistProducts(
        event.query,
      );
      emit(WishlistStateLoaded(products: searchedProducts));
    } catch (e) {
      emit(WishlistStateError(error: e.toString()));
    }
  }
}
