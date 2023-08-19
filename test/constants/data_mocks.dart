import 'package:flutter_riverpod_clean_architecture/data/models/product_category_model.dart';
import 'package:flutter_riverpod_clean_architecture/data/models/product_model.dart';

const categoryId = '1';
const categoryName = 'Boissons';

const id = 'coca';
const name = 'Coca';
const price = 1.29;

const tProductCategoryMap = {"name": categoryName, "id": categoryId};
const tProductMap = {
  "id": id,
  "name": name,
  "price": price,
  "description": null,
  'category': tProductCategoryMap,
};

const tProductCategoryModel = ProductCategoryModel(id: categoryId, name: categoryName);
const tProductModel = ProductModel(id: id, name: name, price: price, category: tProductCategoryModel);

const tProducts = [
  tProductModel,
  ProductModel(id: 'fanta', name: 'Fanta', price: 1.19, category: tProductCategoryModel),
];
