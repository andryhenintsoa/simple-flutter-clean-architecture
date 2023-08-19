import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/cart_item_entity.dart';

class CartEntity extends Equatable {
  final List<CartItemEntity> cartItems;

  const CartEntity({
    required this.cartItems,
  });

  @override
  List<Object> get props => [cartItems];
}
