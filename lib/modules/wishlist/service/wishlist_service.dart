import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistService {
  final _supabase = Supabase.instance.client;

  Future<bool> isProductWished(String productId) async {
    final userId = _supabase.auth.currentUser?.id;
    final response =
        await _supabase
            .from('wishlist')
            .select('id')
            .eq('user_id', userId ?? '')
            .eq('product_id', productId)
            .maybeSingle();

    return response != null;
  }

  Future<void> addToWishlist(String productId) async {
    final userId = _supabase.auth.currentUser?.id;
    await _supabase.from('wishlist').insert({
      'user_id': userId ?? '',
      'product_id': productId,
    });
  }

  Future<void> removeFromWishlist(String productId) async {
    final userId = _supabase.auth.currentUser?.id;
    await _supabase
        .from('wishlist')
        .delete()
        .eq('user_id', userId ?? '')
        .eq('product_id', productId);
  }

  Future<List<ProductModel>> fetchWishlistProducts() async {
    final userId = _supabase.auth.currentUser?.id;
    final data = await _supabase
        .from('wishlist')
        .select('product:products(*)')
        .eq('user_id', userId ?? '');

    return (data as List).map((item) {
      return ProductModel.fromJson(item['product']);
    }).toList();
  }

  Future<List<ProductModel>> searchWishlistProducts(String query) async {
    final userId = _supabase.auth.currentUser?.id;
    final data = await _supabase
        .from('wishlist')
        .select('product:products(*)')
        .eq('user_id', userId ?? '')
        .ilike(
          'product.title',
          '%$query%',
        ); // search on title (case-insensitive)

    return (data as List).map((item) {
      return ProductModel.fromJson(item['product']);
    }).toList();
  }
}
