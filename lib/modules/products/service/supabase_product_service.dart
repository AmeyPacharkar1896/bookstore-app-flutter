import 'dart:developer';

import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductService {
  final SupabaseClient _client = Supabase.instance.client;

  SupabaseProductService();

  // fetch all products
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final response = await _client
          .from('products')
          .select()
          .order('created_at', ascending: false);

      log('[fetchAllProducts] Fetched ${response.length} products');

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('[fetchAllProducts] Error: $e', stackTrace: stackTrace);
      rethrow; // Let Bloc/UI handle the error message
    }
  }

  //fetch by id
  Future<ProductModel?> fetchProductById(String productId) async {
    try {
      final response =
          await _client
              .from('products')
              .select()
              .eq('id', productId)
              .maybeSingle(); // returns null if not found

      if (response == null) {
        log('[fetchProductById] Product not found: $productId');
        return null;
      }

      log(
        '[fetchProductById] Fetched product: ${response['title']} (${response['id']})',
      );

      return ProductModel.fromJson(response);
    } catch (e, stackTrace) {
      log('[fetchProductById] Error: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  //fetch by category
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('category', category)
          .eq('active', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false);

      log(
        '[fetchProductsByCategory] Fetched ${response.length} products in category: $category',
      );

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('[fetchProductsByCategory] Error: $e', stackTrace: stackTrace);
      rethrow; // Let Bloc/UI handle the error message
    }
  }

  //fetch by product type
  Future<List<ProductModel>> fetchProductByType(String productType) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('product_type', productType)
          .eq('active', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false);

      log(
        '[fetchProductByType] Fetched ${response.length} products of type: $productType',
      );

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('[fetchProductByType] Error: $e', stackTrace: stackTrace);
      rethrow; // Let Bloc/UI handle the error message
    }
  }

  //search products by title or author
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .or('title.ilike.%$query%,author.ilike.%$query%,product_type.ilike.%$query%')
          .eq('active', true)
          .isFilter('deleted_at', null);

      log(
        '[searchProducts] Fetched ${response.length} products for query: $query',
      );

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('[searchProducts] Error: $e', stackTrace: stackTrace);
      rethrow; // Let Bloc/UI handle the error message
    }
  }

  //sort products by a specific field
  Future<List<ProductModel>> sortProducts({
    required String sortBy,
    bool ascending = true,
  }) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('active', true)
          .isFilter('deleted_at', null)
          .order(sortBy, ascending: ascending);

      log(
        '[sortProducts] Fetched ${response.length} products sorted by $sortBy',
      );

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('[sortProducts] Error: $e', stackTrace: stackTrace);
      rethrow; // Let Bloc/UI handle the error message
    }
  }

  //filter products by tag
  Future<List<ProductModel>> filterByTag(String tag) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .contains('tags', [tag])
          .eq('active', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false);

      log('[filterByTag] Fetched ${response.length} products with tag: $tag');

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('[filterByTag] Error: $e', stackTrace: stackTrace);
      rethrow; // Let Bloc/UI handle the error message
    }
  }
}
