import 'package:flutter_riverpod_clean_architecture/core/errors/exceptions/exceptions.dart';
import 'package:flutter_riverpod_clean_architecture/core/errors/failures/failures.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/fos.dart';
import 'package:flutter_riverpod_clean_architecture/data/repositories/product_repository_imp.dart';
import 'package:flutter_riverpod_clean_architecture/data/services/product/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../constants/data_mocks.dart';

class MockProductService extends Mock implements ProductService {}

void main() {
  late MockProductService productService;
  late ProductRepositoryImp productRepositoryImp;

  setUp(() {
    productService = MockProductService();
    productRepositoryImp = ProductRepositoryImp(
      productService: productService,
    );
  });

  group("Fetch", () {
    test('Should return SuccessResponse(UserEntity) when request success', () async {
      when(() => productService.fetch()).thenAnswer(
        (_) async => tProducts,
      );

      final result = await productRepositoryImp.fetch();

      expect(result, const SuccessResponse(tProducts));
    });

    const UnauthorizedException unauthorizedException = UnauthorizedException();
    const networkException = NetworkException();
    const ServerException serverException = ServerException();
    const unknownSignInException = UnknownException(message: "unknownException fetch");

    test('Should return FailureResponse(UnauthorizedFailure) when throw UnauthorizedException ', () async {
      when(() => productService.fetch()).thenThrow(unauthorizedException);

      final result = await productRepositoryImp.fetch();

      expect(
        result,
        FailureResponse(
          UnauthorizedFailure(
            message: unauthorizedException.message,
            code: unauthorizedException.code,
          ),
        ),
      );
    });

    test('Should return FailureResponse(NetworkFailure) when throw NetworkException ', () async {
      when(() => productService.fetch()).thenThrow(networkException);

      final result = await productRepositoryImp.fetch();

      expect(
        result,
        FailureResponse(
          NetworkFailure(
            message: networkException.message,
            code: networkException.code,
          ),
        ),
      );
    });

    test('Should return FailureResponse(ServerFailure) when throw ServerException ', () async {
      when(() => productService.fetch()).thenThrow(serverException);

      final result = await productRepositoryImp.fetch();

      expect(
        result,
        FailureResponse(
          ServerFailure(
            message: serverException.message,
            code: serverException.code,
          ),
        ),
      );
    });

    test('Should return FailureResponse(UnknownException) when throw UnknownException ', () async {
      when(() => productService.fetch()).thenThrow(
        unknownSignInException,
      );

      final result = await productRepositoryImp.fetch();

      expect(
        result,
        FailureResponse(
          UnknownFailure(
            message: unknownSignInException.message,
          ),
        ),
      );
    });
  });
}
