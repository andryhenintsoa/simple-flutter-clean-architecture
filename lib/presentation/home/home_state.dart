import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/failure.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';

enum HomeStatus {
  init,
  loading,
  success,
  failure,
}

extension StatusExtension on HomeStatus {
  bool get isInit => this == HomeStatus.init;

  bool get isLoading => this == HomeStatus.loading;

  bool get isSuccess => this == HomeStatus.success;

  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ProductEntity> products;
  final Map<String, num> cart;
  final Failure? failure;

  const HomeState({
    this.status = HomeStatus.init,
    this.products = const [],
    this.cart = const {},
    this.failure,
  });

  @override
  List<Object?> get props => [
        status,
        products,
        cart,
        failure,
      ];

  HomeState copyWith({
    HomeStatus? status,
    List<ProductEntity>? products,
    Map<String, num>? cart,
    Failure? failure,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      failure: failure ?? this.failure,
    );
  }

  num get total => cart.entries.map((entry) {
        final productId = entry.key;
        final count = entry.value;
        return (products.firstWhereOrNull((product) => productId == product.id)?.price ?? 0) * count;
      }).sum;
}
