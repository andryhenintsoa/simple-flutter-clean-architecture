import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/failure.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/fos.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Fos<Failure, CartEntity>> getCart();

  Future<Fos<Failure, void>> updateCart(CartEntity? cart);
}
