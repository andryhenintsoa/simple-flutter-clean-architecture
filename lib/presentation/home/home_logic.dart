import 'dart:async';

import 'package:flutter_riverpod_clean_architecture/dependencies/injection.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/home/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeStateNotifierProvider = StateNotifierProvider.autoDispose<HomeStateNotifier, HomeState>(
  (ref) => HomeStateNotifier(
    const HomeState(),
    productRepository: ref.read(productRepository),
  ),
);

class HomeStateNotifier extends StateNotifier<HomeState> {
  final ProductRepository productRepository;

  HomeStateNotifier(super.state, {required this.productRepository});

  FutureOr<void> initialize() async {
    state = state.copyWith(status: HomeStatus.loading);
    final result = await productRepository.fetch();

    result.on((failure) {
      state = state.copyWith(status: HomeStatus.failure, failure: failure);
    }, (success) {
      state = state.copyWith(status: HomeStatus.success, products: success, failure: null);
    });
  }

  void addItemOnCart(ProductEntity product) {
    final cart = Map.of(state.cart);
    final newQuantity = (cart[product.id] ?? 0) + 1;
    setProductQuantity(product, newQuantity);
  }

  void reduceItemOnCart(ProductEntity product) {
    final cart = Map.of(state.cart);
    final newQuantity = cart[product.id]! - 1;
    setProductQuantity(product, newQuantity);
  }

  void setProductQuantity(ProductEntity product, num newQuantity) {
    final cart = Map.of(state.cart);

    if (newQuantity <= 0) {
      cart.remove(product.id);
    } else {
      cart[product.id] = newQuantity;
    }

    state = state.copyWith(cart: cart);
  }
}
