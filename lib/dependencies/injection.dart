import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/data/repositories/product_repository_imp.dart';
import 'package:flutter_riverpod_clean_architecture/data/services/product/product_service.dart';
import 'package:flutter_riverpod_clean_architecture/data/services/product/product_service_imp.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/product_repository.dart';

final productService = StateProvider<ProductService>((ref) => ProductServiceImp());

final productRepository =
    StateProvider<ProductRepository>((ref) => ProductRepositoryImp(productService: ref.read(productService)));
