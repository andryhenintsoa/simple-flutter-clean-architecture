import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/failure.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/fos.dart';
import 'package:flutter_riverpod_clean_architecture/dependencies/injection.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/home/home_logic.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../constants/data_mocks.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class MockFailure extends Mock implements Failure {}

void main() {
  late ProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
  });

  test('Initial state', () async {
    final container = ProviderContainer(
      overrides: [
        productRepository.overrideWith((ref) => mockProductRepository),
      ],
    );

    final state = container.read(homeStateNotifierProvider);

    expect(state.status, equals(HomeStatus.init));
    expect(state.products, isEmpty);
    expect(state.cart, isEmpty);
    expect(state.failure, isNull);
  });

  group("Initialization", () {
    test('State should contain list of products when request success without any error', () async {
      final container = ProviderContainer(
        overrides: [
          productRepository.overrideWith((ref) => mockProductRepository),
        ],
      );

      when(() => mockProductRepository.fetch()).thenAnswer(
        (_) async => const SuccessResponse(tProducts),
      );

      await container.read(homeStateNotifierProvider.notifier).initialize();

      final state = container.read(homeStateNotifierProvider);

      expect(state.status, equals(HomeStatus.success));
      expect(state.products, tProducts);
      expect(state.cart, isEmpty);
      expect(state.failure, isNull);
    });

    final mockFailure = MockFailure();

    test('When having a failure, state should have no product and contain the failure', () async {
      final container = ProviderContainer(
        overrides: [
          productRepository.overrideWith((ref) => mockProductRepository),
        ],
      );

      when(() => mockProductRepository.fetch()).thenAnswer(
        (_) async => FailureResponse(mockFailure),
      );

      await container.read(homeStateNotifierProvider.notifier).initialize();

      final state = container.read(homeStateNotifierProvider);

      expect(state.status, equals(HomeStatus.failure));
      expect(state.products, isEmpty);
      expect(state.cart, isEmpty);
      expect(state.failure, mockFailure);
    });
  });

  group("Fetch", () {
    test('Add item', () async {
      final container = ProviderContainer(
        overrides: [
          productRepository.overrideWith((ref) => mockProductRepository),
        ],
      );

      when(() => mockProductRepository.fetch()).thenAnswer(
        (_) async => const SuccessResponse(tProducts),
      );

      await container.read(homeStateNotifierProvider.notifier).initialize();

      final product = tProducts[0];
      const targetCount = 37;
      for (var i = 0; i < targetCount; i++) {
        container.read(homeStateNotifierProvider.notifier).addItemOnCart(product);
      }

      final state = container.read(homeStateNotifierProvider);

      expect(state.status, equals(HomeStatus.success));
      expect(state.products, tProducts);
      expect(state.cart, {product.id: targetCount});
      expect(state.failure, isNull);
    });
  });

  test('Set quantity on item', () async {
    final container = ProviderContainer(
      overrides: [
        productRepository.overrideWith((ref) => mockProductRepository),
      ],
    );

    when(() => mockProductRepository.fetch()).thenAnswer(
      (_) async => const SuccessResponse(tProducts),
    );

    await container.read(homeStateNotifierProvider.notifier).initialize();

    final product = tProducts[0];
    const targetCount = 12;
    container.read(homeStateNotifierProvider.notifier).setProductQuantity(product, targetCount);

    final state = container.read(homeStateNotifierProvider);

    expect(state.status, equals(HomeStatus.success));
    expect(state.products, tProducts);
    expect(state.cart, {product.id: targetCount});
    expect(state.failure, isNull);
  });

  test('Reduce item quantity to a positive quantity', () async {
    final container = ProviderContainer(
      overrides: [
        productRepository.overrideWith((ref) => mockProductRepository),
      ],
    );

    when(() => mockProductRepository.fetch()).thenAnswer(
      (_) async => const SuccessResponse(tProducts),
    );

    await container.read(homeStateNotifierProvider.notifier).initialize();

    final product = tProducts[0];
    const targetCount = 55;
    const initialCount = 60;
    const removeCount = initialCount - targetCount;
    container.read(homeStateNotifierProvider.notifier).setProductQuantity(product, initialCount);


    for (var i = 0; i < removeCount; i++) {
      container.read(homeStateNotifierProvider.notifier).reduceItemOnCart(product);
    }

    final state = container.read(homeStateNotifierProvider);

    expect(state.status, equals(HomeStatus.success));
    expect(state.products, tProducts);
    expect(state.cart, {product.id: targetCount});
    expect(state.failure, isNull);
  });

  test('Reduce item quantity to a negative quantity', () async {
    final container = ProviderContainer(
      overrides: [
        productRepository.overrideWith((ref) => mockProductRepository),
      ],
    );

    when(() => mockProductRepository.fetch()).thenAnswer(
      (_) async => const SuccessResponse(tProducts),
    );

    await container.read(homeStateNotifierProvider.notifier).initialize();

    final product = tProducts[0];
    const targetCount = -14;
    const initialCount = 60;
    const removeCount = initialCount - targetCount;
    container.read(homeStateNotifierProvider.notifier).setProductQuantity(product, targetCount);


    for (var i = 0; i < removeCount; i++) {
      container.read(homeStateNotifierProvider.notifier).reduceItemOnCart(product);
    }

    final state = container.read(homeStateNotifierProvider);

    expect(state.status, equals(HomeStatus.success));
    expect(state.products, tProducts);
    expect(state.cart, {});
    expect(state.failure, isNull);
  });
}
