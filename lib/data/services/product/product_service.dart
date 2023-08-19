import 'package:flutter_riverpod_clean_architecture/data/models/product_model.dart';

abstract class ProductService {
  Future<List<ProductModel>> fetch();
}
