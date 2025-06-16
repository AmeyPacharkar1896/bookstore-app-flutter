class ProductModel {
  final String id;
  final String title;
  final String author;
  final String? isbn;
  final String? category;
  final String productType;
  final double price;
  final double? salePrice;
  final int stockQuantity;
  final String? description;
  final String? publisher;
  final DateTime? publicationDate;
  final int? pages;
  final String? language;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? coverUrl;
  final double averageRating;
  final int ratingCount;
  final List<String>? tags;
  final String? slug;
  final DateTime? deletedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.author,
    this.isbn,
    this.category,
    required this.productType,
    required this.price,
    this.salePrice,
    required this.stockQuantity,
    this.description,
    this.publisher,
    this.publicationDate,
    this.pages,
    this.language,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.coverUrl,
    required this.averageRating,
    required this.ratingCount,
    this.tags,
    this.slug,
    this.deletedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      isbn: map['isbn'],
      category: map['category'],
      productType: map['product_type'],
      price: double.parse(map['price'].toString()),
      salePrice:
          map['sale_price'] != null
              ? double.parse(map['sale_price'].toString())
              : null,
      stockQuantity: map['stock_quantity'] ?? 0,
      description: map['description'],
      publisher: map['publisher'],
      publicationDate:
          map['publication_date'] != null
              ? DateTime.tryParse(map['publication_date'])
              : null,
      pages: map['pages'],
      language: map['language'],
      active: map['active'] ?? true,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      coverUrl: map['cover_url'],
      averageRating:
          map['average_rating'] != null
              ? double.parse(map['average_rating'].toString())
              : 0.0,
      ratingCount: map['rating_count'] ?? 0,
      tags: (map['tags'] as List?)?.cast<String>(),
      slug: map['slug'],
      deletedAt:
          map['deleted_at'] != null
              ? DateTime.tryParse(map['deleted_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'category': category,
      'product_type': productType,
      'price': price,
      'sale_price': salePrice,
      'stock_quantity': stockQuantity,
      'description': description,
      'publisher': publisher,
      'publication_date': publicationDate?.toIso8601String(),
      'pages': pages,
      'language': language,
      'active': active,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'cover_url': coverUrl,
      'average_rating': averageRating,
      'rating_count': ratingCount,
      'tags': tags,
      'slug': slug,
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
