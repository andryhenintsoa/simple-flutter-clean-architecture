import 'package:flutter_riverpod_clean_architecture/data/models/product_category_model.dart';
import 'package:flutter_riverpod_clean_architecture/domain/entities/product_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../constants/data_mocks.dart';

void main() {
  test("ProductCategoryModel Should be subclass ProductCategoryEntity", () {
    expect(tProductCategoryModel, isA<ProductCategoryEntity>());
  });

  test("FromJson should return ProductCategoryModel", () {
    expect(ProductCategoryModel.fromJson(tProductCategoryMap), tProductCategoryModel);
  });

  test("toJson should return Map<String,dynamic>", () {
    expect(tProductCategoryModel.toJson(), tProductCategoryMap);
  });
}