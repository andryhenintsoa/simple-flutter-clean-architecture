import 'package:flutter_riverpod_clean_architecture/domain/entities/product_category_entity.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  const ProductCategoryModel({
    required super.id,
    required super.name,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map["id"],
      name: map["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
