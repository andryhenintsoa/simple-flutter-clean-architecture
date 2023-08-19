import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod_clean_architecture/core/errors/exceptions/exceptions.dart';
import 'package:flutter_riverpod_clean_architecture/data/models/product_model.dart';
import 'package:flutter_riverpod_clean_architecture/data/services/product/product_service.dart';

class ProductServiceImp extends ProductService {
  final dataPath = 'assets/data/products.json';

  @override
  Future<List<ProductModel>> fetch() async {
    try {
      final String rawJson = await rootBundle.loadString(dataPath);
      final data = json.decode(rawJson) as Map;
      final successData = data['data'] as List;
      final products = successData.map((element) => ProductModel.fromJson(element as Map<String, dynamic>)).toList();
      return products;
    } catch (e) {
      throw UnknownException(message: "$e");
    }
  }
}
