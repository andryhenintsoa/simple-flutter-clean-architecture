import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/data/repositories/product_repository_imp.dart';
import 'package:flutter_riverpod_clean_architecture/data/services/product/product_service_imp.dart';

final productService = StateProvider((ref) => ProductServiceImp());

final productRepository = StateProvider((ref) => ProductRepositoryImp(productService: ref.read(productService)));
