import 'package:flutter_riverpod_clean_architecture/core/errors/exceptions/exceptions.dart';
import 'package:flutter_riverpod_clean_architecture/core/errors/failures/failures.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/failure.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/fos.dart';
import 'package:flutter_riverpod_clean_architecture/data/services/product/product_service.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/product_repository.dart';

class ProductRepositoryImp extends ProductRepository {
  final ProductService productService;

  ProductRepositoryImp({required this.productService});

  @override
  Future<Fos<Failure, List<ProductEntity>>> fetch() async {
    try {
      final result = await productService.fetch();
      return SuccessResponse(result);
    } on UnauthorizedException catch (e) {
      return FailureResponse(
        UnauthorizedFailure(code: e.code, message: e.message),
      );
    } on NetworkException catch (e) {
      return FailureResponse(
        NetworkFailure(code: e.code, message: e.message),
      );
    } on ServerException catch (e) {
      return FailureResponse(
        ServerFailure(code: e.code, message: e.message),
      );
    } catch (e) {
      return const FailureResponse(
        UnknownFailure(
          message: "unknownException fetch",
        ),
      );
    }
  }
}
