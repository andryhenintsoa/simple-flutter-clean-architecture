import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_category_entity.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final num price;
  final ProductCategoryEntity category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
  });

  @override
  List<Object> get props => [id, name, price, category];

  @override
  String toString() => '$name ($id)';
}
