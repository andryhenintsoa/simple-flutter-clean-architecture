import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object> get props => [product, quantity];

  @override
  String toString() => '$product - (quantity : $quantity)';
}
