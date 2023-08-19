import 'package:flutter_riverpod_clean_architecture/data/models/product_model.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../constants/data_mocks.dart';

void main() {
  test("ProductModel Should be subclass ProductEntity", () {
    expect(tProductModel, isA<ProductEntity>());
  });

  test("FromJson should return ProductModel", () {
    expect(ProductModel.fromJson(tProductMap), tProductModel);
  });

  test("toJson should return Map<String,dynamic>", () {
    expect(tProductModel.toJson(), tProductMap);
  });
}
