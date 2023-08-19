
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/failure.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/failure_or_success/fos.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Fos<Failure, List<ProductEntity>>> fetch();
}
