import 'package:flutter_riverpod_clean_architecture/data/models/product_category_model.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    super.description,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      name: map["name"],
      description: map['description'],
      price: map['price'],
      category: ProductCategoryModel.fromJson(map['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "category": {
        "id": category.id,
        "name": category.name,
      },
    };
  }
}
